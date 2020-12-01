USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  StoredProcedure [dbo].[SPSimulacion]    Script Date: 30/11/2020 19:46:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER     PROCEDURE [dbo].[SPSimulacion]
AS

BEGIN
	SET NOCOUNT ON

	
	
	--DECLARE @TablaMovimientoAux AS [dbo].[TableMovimientos];
	DECLARE @FechaDeOperacion DATE

	-- Tabla para almacenas las fechas según el XML.
	DECLARE @FechasPorIterar TABLE
		(
			 iterador INT IDENTITY(1,1) PRIMARY KEY
			,fecha DATE
		)

	-- Sección para cargar las fechas desde el XML y parsearlo antes.

	BEGIN TRY
		--Parsear el XML e insertar datos en la tabla
		DECLARE 
				@DocumentoXML XML;
	
		SELECT 
			@DocumentoXML = DXML
		FROM 
			--OPENROWSET(BULK 'D:\S3\bucket-xml\PruebaOperaciones.xml', SINGLE_BLOB) AS DocumentoXML(DXML);
			OPENROWSET(BULK 'C:\Users\ulirp\Desktop\BAses\Base_De_Datos_Progra_1\Base De Datos\XML\Datos_Tarea_2.xml', SINGLE_BLOB) AS DocumentoXML(DXML);
		INSERT 
			@FechasPorIterar (fecha)

		SELECT 
			f.value('@Fecha','DATE')
		FROM 
			@DocumentoXML.nodes('/Operaciones/FechaOperacion')AS t(f);

	END TRY

	BEGIN CATCH
			PRINT 'ERROR AL PARSEAR EL XML EN LA SIMULACIÓN.'
			--RETURN @@ERROR;
	END CATCH
	


	-- Sección donde vamos a declarar las variables para poder iterar por día.
	DECLARE @primerDia INT
	DECLARE @ultimoDia INT
	DECLARE @fechaMinima DATETIME
	DECLARE @fechaMaxima DATETIME

	-- Asignamos las fechas a cada variable con MIN y MAX (funciones agregadas)
	SELECT 
		@fechaMinima = MIN(F.fecha)
	FROM @FechasPorIterar F
	
	SELECT 
		@fechaMaxima = MAX(F.fecha)
	FROM @FechasPorIterar F
	
	-- Inicializamos las variables inicio y fin de fechas con las cuales se va a recorrer la simulación.
	SELECT 
		@primerDia = F.iterador
	FROM
		@FechasPorIterar F
	WHERE
		F.fecha = @fechaMinima
	
	SELECT 
		@ultimoDia = F.iterador
	FROM
		@FechasPorIterar F
	WHERE
		F.fecha = @fechaMaxima
	PRINT(@primerDia)

	--SELECT * FROM @FechasPorIterar
	-- Comezamo la simulación con un WHILE iniciando desde @primerDia hasta @ultimoDia.
	WHILE 
		@primerDia <= @ultimoDia

		BEGIN
			
			-- Obtenemos la fecha según el índice de la tabla fechas.
			SELECT 
				@FechaDeOperacion = F.fecha
			FROM
				@FechasPorIterar F
			WHERE 
				iterador = @primerDia

			PRINT(@primerDia)
			-- COMENZAMOS A PROCESAR LOS NODOS PRINCIPALES.
				
			-- PERSONAs
			INSERT
				[dbo].[Persona]
							(
								 IdTipoDocumentoIdentidad
								,Nombre
								,ValorDocumentoIdentidad
								,FechaNacimiento
								,CorreoElectronico
								,Telefono1
								,Telefono2
								,InsertAt
								,UpdateAt
								,InsertBy
								,UpdateBy
								,InsertIn
								,UpdateIn
							)
			SELECT 
				 p.value('@TipoDocuIdentidad','INT')
				,p.value('@Nombre','VARCHAR(100)')
				,p.value('@ValorDocumentoIdentidad','INT')
				,p.value('@FechaNacimiento','DATE')
				,p.value('@Email','VARCHAR(50)')
				,p.value('@Telefono1','VARCHAR(50)')
				,p.value('@Telefono2','VARCHAR(50)')
				, @FechaDeOperacion AS [InsertAt] --obtiene la fecha del dia de insercion
				, null AS [UpdateAt] --obtiene la fecha del dia de actualizacion
				, CURRENT_USER AS [InsertBy] --string de prueba
				, '' AS [UpdateBy] --string de prueba
				, 'DESKTOP-FBGDAQE' AS [InsertIn] --string de prueba
				, '' AS [UpdateIn] --string de prueba

			FROM
				@DocumentoXML.nodes('/Operaciones/FechaOperacion/Persona')
			AS
				t(p)
			WHERE		-- Esto para poder obtener sólo cuando es la fecha correcta.
				@DocumentoXML.value('(/Operaciones/FechaOperacion/@Fecha)[1]','DATE') = @FechaDeOperacion	--REVISAR NO FILTRA




			
			INSERT INTO [dbo].[CuentaAhorro]
			(
				 [IdPersona]
				,[IdTipoCuenta]
				,[NumeroDeCuenta]
				,[FechaCreacion]
				,[Saldo]
				,[InsertAt]
				,[UpdateAt]
				,[InsertBy]
				,[UpdateBy]
				,[InsertIn]
				,[UpdateIn]
			)
			SELECT	
				(	
					SELECT 
							P.Id
					FROM 
							[dbo].[Persona] P
					WHERE 
							CA.value('@ValorDocumentoIdentidadDelCliente', 'INT') = P.ValorDocumentoIdentidad
				) AS 
						[IdPersona]

				, CA.value('@TipoCuentaId', 'INT')
				, CA.value('@NumeroCuenta', 'INT')
				, @FechaDeOperacion AS [FechaCreacion]
				, 0 AS [Saldo]
				, @FechaDeOperacion AS [InsertAt] --obtiene la fecha del dia de insercion
				, null AS [UpdateAt] --obtiene la fecha del dia de actualizacion
				, 'CURRENT_USER' AS [InsertBy] --string de prueba
				, 'CURRENT_USER' AS [UpdateBy] --string de prueba
				, 'DESKTOP-FBGDAQE' AS [InsertIn] --string de prueba
				, ' ' AS [UpdateIn] --string de prueba

			FROM
				@DocumentoXML.nodes('/Operaciones/FechaOperacion/Cuenta')
			AS
				t(CA)
				
			WHERE		-- Esto para poder obtener sólo cuando es la fecha correcta.
				@DocumentoXML.value('(/Operaciones/FechaOperacion/@Fecha)[1]','DATE') = @FechaDeOperacion	--REVISAR NO FILTRA

			

			
			--**************************************************************
			--**************************************************************
			--**************************************************************
			--**************************************************************
			--AQUÍ DEBERÍA DE ENTRAR A FUNCIONAR EL TRIGGER DE ESTADO CUENTA.
			--**************************************************************
			--**************************************************************
			--**************************************************************
			--**************************************************************
			--**************************************************************

			



			INSERT INTO [dbo].[Beneficiario]
								(
									 [IdPersona]
									,[IdCuentaDeAhorro]
									,[IdTipoParentezco]
									,[Porcentaje]
									,[Activo]
									,[InsertAt]
									,[UpdateAt]
									,[InsertBy]
									,[UpdateBy]
									,[InsertIn]
									,[UpdateIn]
								)
			SELECT	 
					-- Con esta fracción de código logramos enlazar el documento de identidad del beneficiario, junto con el IdPersona.
				(	
					SELECT 
							P.Id
					FROM 
							[dbo].[Persona] P
					WHERE 
							d.value('@ValorDocumentoIdentidadBeneficiario', 'INT') = P.ValorDocumentoIdentidad
				) AS [IdPersona]
				
					-- Aquí enlazamos el número de cuenta con su respectiva cuenta xD.
				,(	
					SELECT 
							C.Id
					FROM 
							[dbo].[CuentaAhorro] C
					WHERE 
							d.value('@NumeroCuenta', 'INT') = C.NumeroDeCuenta
				) AS [IdCuentaDeAhorro]
				--,  1 AS [IdTipoParentezco] 
				, d.value('@ParentezcoId', 'INT')
				, d.value('@Porcentaje', 'INT')

				, 1 AS [Activo]

				, @FechaDeOperacion AS [InsertAt] --obtiene la fecha del dia de insercion
				, null AS [UpdateAt] --obtiene la fecha del dia de actualizacion
				, 'CURRENT_USER' AS [InsertBy] --string de prueba
				, '' AS [UpdateBy] --string de prueba
				, 'DESKTOP-FBGDAQE' AS [InsertIn] --string de prueba
				, '' AS [UpdateIn] --string de prueba
			FROM 
				@DocumentoXML.nodes('/Operaciones/FechaOperacion/Beneficiario') 
			AS 
				t(d)

			WHERE		-- Esto para poder obtener sólo cuando es la fecha correcta.
				@DocumentoXML.value('(/Operaciones/FechaOperacion/@Fecha)[1]','DATE') = @FechaDeOperacion	--REVISAR NO FILTRA



			--DELETE 
			--	@TablaMovimientoAux
			--INSERT INTO 
			--	@TablaMovimientoAux(idTipoMovimiento,numeroCuenta,monto,fecha,descripcion)
			SELECT 
				  m.value('@Tipo', 'INT')
				, m.value('@CodigoCuenta', 'INT')
				, m.value('@Monto', 'MONEY')
				, @FechaDeOperacion AS fecha
				, m.value('@Descripcion','VARCHAR(100)')
			FROM 
				@DocumentoXML.nodes('/Operaciones/FechaOperacion[@Fecha eq sql:variable("@FechaDeOperacion")]/Movimientos') AS t(m)
			--EXEC [dbo].[SPInsertarMovimientoSimulacion] @TablaMovimientoAux;



			--INSERT INTO [dbo].[Movimiento]
			--					(
									 
			--						 [IdTipoMovimiento]
			--						,[IdCuentaAhorro]
			--						,[IdEstadoDeCuenta]
			--						,[Monto]
			--						,[Fecha]
			--						,[Descripcion]
			--					)
			--SELECT	 
				
			--	 d.value('@Tipo', 'INT')
			--	,(SELECT C.Id FROM [dbo].[CuentaAhorro] C WHERE d.value('@CodigoCuenta', 'INT') = C.NumeroDeCuenta) AS [IdCuentaAhorro]
			--	,(SELECT EC.Id FROM [dbo].[EstadoCuenta] EC WHERE IdCuentaDeAhorro = 
			--	INNER JOIN Cuen
			--	) AS [IdCuentaAhorro]				

			--	, 1 AS [Activo]

			--	, @FechaDeOperacion AS [InsertAt] --obtiene la fecha del dia de insercion
			--	, null AS [UpdateAt] --obtiene la fecha del dia de actualizacion
			--	, 'CURRENT_USER' AS [InsertBy] --string de prueba
			--	, '' AS [UpdateBy] --string de prueba
			--	, 'DESKTOP-FBGDAQE' AS [InsertIn] --string de prueba
			--	, '' AS [UpdateIn] --string de prueba
			--FROM 
			--	@DocumentoXML.nodes('/Operaciones/FechaOperacion/Beneficiario') 
			--AS 
			--	t(d)

			--WHERE		-- Esto para poder obtener sólo cuando es la fecha correcta.
			--	@DocumentoXML.value('(/Operaciones/FechaOperacion/@Fecha)[1]','DATE') = @FechaDeOperacion	--REVISAR NO FILTRA





			SET @primerDia = @primerDia + 1
		END --Fin WHILE






END