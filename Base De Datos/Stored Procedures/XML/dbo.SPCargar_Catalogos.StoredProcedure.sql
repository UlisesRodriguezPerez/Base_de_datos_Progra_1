USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  StoredProcedure [dbo].[SPCargar_Catalogos]    Script Date: 18/1/2021 17:17:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER   PROCEDURE [dbo].[SPCargar_Catalogos]
AS
BEGIN

	BEGIN TRY 
		/*    Parsear el XML e insertar datos en la tabla    */
		DECLARE 
				@DocumentoXML XML;
		SELECT 
				@DocumentoXML = DXML
		FROM 
				--OPENROWSET(BULK 'D:\S3\bucket-xml\PruebaCatalogo.xml', SINGLE_BLOB) AS DocumentoXML(DXML);  
				--OPENROWSET(BULK 'C:\Users\ulirp\Desktop\BAses\Base_De_Datos_Progra_1\Base De Datos\XML\Datos_Tarea_2_CatalogosPR2.xml', SINGLE_BLOB) AS DocumentoXML(DXML);
				OPENROWSET(BULK 'C:\Users\ulirp\Desktop\BAses\Base_De_Datos_Progra_1\Base De Datos\XML\Datos-Tarea3-Catalogos.xml', SINGLE_BLOB) AS DocumentoXML(DXML);
				--OPENROWSET(BULK 'C:\Users\famil\OneDrive\Documents\GitHub\Base_De_Datos_Progra_1\Base De Datos\XML\Datos-Tarea3-Catalogos.xml', SINGLE_BLOB) AS DocumentoXML(DXML);
	END TRY

	BEGIN CATCH
		EXEC [dbo].[SPManejoDeErrores] @ErrorLogId = 0 ,@CodigoDeError = 50008, @Descripcion = 'Problemas al parsear XML (SPCargar_Catalogo)'
			--PRINT 'Problemas al cargar el xml Seccion Catalogo'
			--RETURN @@ERROR;
	END CATCH

	BEGIN TRY
					/* Inserta en las siguientes tablas sus valores correspondientes, según el XML.*/
			INSERT INTO [dbo].[TipoDocumentoIdentidad](
														 [Id]
														 ,[Nombre]
													  )
			SELECT	
					  d.value('@Id', 'INT')
					, d.value('@Nombre', 'VARCHAR(100)')
			FROM 
					@DocumentoXML.nodes('/TipoDoc/TipoDocuIdentidad') AS t(d)
	END TRY

	BEGIN CATCH
		EXEC [dbo].[SPManejoDeErrores] @ErrorLogId = 0 ,@CodigoDeError = 50009, @Descripcion = 'ERROR AL INSERTAR DATOS EN LA TABLA [TipoDocumentoIdentidad] (SPCargar_Catalogo)'
			--PRINT  'ERROR AL INSERTAR DATOS EN LA TABLA [TipoDocumentoIdentidad].'
			--RETURN @@ERROR;
	END CATCH


	BEGIN TRY 
			INSERT INTO [dbo].[TipoMoneda](
											 [Id]
											 ,[Nombre]
											 ,[Simbolo]
										  )
			SELECT	
					  d.value('@Id', 'INT')
					, d.value('@Nombre', 'VARCHAR(100)')
					, d.value('@Simbolo', 'nvarchar(1)')
			FROM 
					@DocumentoXML.nodes('/TipoMoneda/TipoMoneda') AS t(d)
	END TRY

	BEGIN CATCH
		EXEC [dbo].[SPManejoDeErrores] @ErrorLogId = 0 ,@CodigoDeError = 50010, @Descripcion = 'ERROR AL INSERTAR DATOS EN LA TABLA [TipoMoneda] (SPCargar_Catalogo)'
			--PRINT  'ERROR AL INSERTAR DATOS EN LA TABLA [TipoMoneda].'
			--RETURN @@ERROR;
	END CATCH


	BEGIN TRY
			INSERT INTO [dbo].[TipoParentezco](
										 [Id]
										,[Nombre]
									)
			SELECT	
					  d.value('@Id', 'INT')
					, d.value('@Nombre', 'VARCHAR(100)')
			FROM 
					@DocumentoXML.nodes('/Parentezcos/Parentezco') AS t(d)
	END TRY

	BEGIN CATCH
		EXEC [dbo].[SPManejoDeErrores] @ErrorLogId = 0 ,@CodigoDeError = 50011, @Descripcion = 'ERROR AL INSERTAR DATOS EN LA TABLA [TipoParentezco] (SPCargar_Catalogo)'
			--PRINT  'ERROR AL INSERTAR DATOS EN LA TABLA [TipoParentezco].'
			--RETURN @@ERROR;
	END CATCH


	BEGIN TRY
				INSERT INTO [dbo].[TipoCuentaAhorro](
													 [Id]
													,[Nombre]
													,[IdTipoMoneda]
													,[SaldoMinimo]
													,[MultaSaldoMinimo]
													,[CargoAnual]
													,[MaxcajeroHumano]
													,[MaxCajeroAutomatico]
													,[CobroCajeroHumano]
													,[CobroCajeroAutomatico]
													--,[ComisionPorServicio]
													,[Interes]
												)
				SELECT	
						  d.value('@Id', 'INT')
						, d.value('@Nombre', 'VARCHAR(100)')
						, d.value('@IdTipoMoneda', 'INT')
						, d.value('@SaldoMinimo', 'MONEY')
						, d.value('@MultaSaldoMin', 'MONEY')
						, d.value('@CargoMensual', 'MONEY')
						, d.value('@NumRetiroHumano', 'INT')
						, d.value('@NumRetirosAutomatico', 'INT')
						, d.value('@ComisionHumano', 'MONEY')
						, d.value('@ComisionAutomatico', 'MONEY')
						--, d.value('@ComisionServicio', 'MONEY')
						, d.value('@Interes', 'INT')
				FROM 
						@DocumentoXML.nodes('/Tipo_Cuenta_Ahorro/TipoCuentaAhorro') AS t(d)
	END TRY

	BEGIN CATCH
		EXEC [dbo].[SPManejoDeErrores] @ErrorLogId = 0 ,@CodigoDeError = 50012, @Descripcion = 'ERROR AL INSERTAR DATOS EN LA TABLA [TipoCuentaAhorro] (SPCargar_Catalogo)'
			--PRINT  'ERROR AL INSERTAR DATOS EN LA TABLA [TipoCuentaAhorro].'
			--RETURN @@ERROR;
	END CATCH


	BEGIN TRY
				INSERT INTO [dbo].[TipoMovimiento](
													 [Id]
													,[Nombre]
													,[Tipo]

												)
				SELECT	
						  d.value('@Id', 'INT')
						, d.value('@Nombre', 'VARCHAR(100)')
						, d.value('@Tipo', 'VARCHAR(50)')

				FROM 
						@DocumentoXML.nodes('/TipoMovimientos/TipoMovimiento') AS t(d)
	END TRY

	BEGIN CATCH
		EXEC [dbo].[SPManejoDeErrores] @ErrorLogId = 0 ,@CodigoDeError = 50013, @Descripcion = 'ERROR AL INSERTAR DATOS EN LA TABLA [TipoMovimiento] (SPCargar_Catalogo)'
			--PRINT  'ERROR AL INSERTAR DATOS EN LA TABLA [TipoMovimiento].'
			--RETURN @@ERROR;
	END CATCH

	BEGIN TRY
				INSERT INTO [dbo].[TipoMovimientoCuentaObjetivo](
													 [Id]
													,[Nombre]
	

												)
				SELECT	
						  d.value('@Id', 'INT')
						, d.value('@Nombre', 'VARCHAR(100)')


				FROM 
						@DocumentoXML.nodes('/TiposMovimientoCuentaAhorro/Tipo_Movimiento') AS t(d)
	END TRY

	BEGIN CATCH
		EXEC [dbo].[SPManejoDeErrores] @ErrorLogId = 0 ,@CodigoDeError = 50104, @Descripcion = 'ERROR AL INSERTAR DATOS EN LA TABLA [TipoMovimientoCuentaObjetivo] (SPCargar_Catalogo)'
			--PRINT  'ERROR AL INSERTAR DATOS EN LA TABLA [TipoMovimiento].'
			--RETURN @@ERROR;
	END CATCH


		BEGIN TRY
				INSERT INTO [dbo].[TipoMovimientoCuentaObjetivoInteres](
													 [Id]
													,[Nombre]
	

												)
				SELECT	
						  d.value('@Id', 'INT')
						, d.value('@Nombre', 'VARCHAR(100)')


				FROM 
						@DocumentoXML.nodes('/TiposMovimientoCuentaAhorro/Tipo_Movimiento') AS t(d)
	END TRY

	BEGIN CATCH
		EXEC [dbo].[SPManejoDeErrores] @ErrorLogId = 0 ,@CodigoDeError = 50104, @Descripcion = 'ERROR AL INSERTAR DATOS EN LA TABLA [TipoMovimientoCuentaObjetivoInteres] (SPCargar_Catalogo)'
			--PRINT  'ERROR AL INSERTAR DATOS EN LA TABLA [TipoMovimiento].'
			--RETURN @@ERROR;
	END CATCH
	/*
	--este codigo ve si hay algo en el xml sin ingresar nada en las tablas

	SELECT * FROM OPENROWSET(  
	   BULK 'D:\S3\bucket-xml\PruebaCatalogo.xml',  
	   SINGLE_BLOB) AS x;  

	SELECT CONVERT(XML, BulkColumn) AS BulkColumn, GETDATE() 
	FROM OPENROWSET(BULK 'D:\S3\bucket-xml\PruebaCatalogo.xml', SINGLE_BLOB) AS x;


	*/
END
