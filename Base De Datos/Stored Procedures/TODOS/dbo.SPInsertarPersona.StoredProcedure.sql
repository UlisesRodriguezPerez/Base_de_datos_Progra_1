USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  StoredProcedure [dbo].[SPInsertarPersona]    Script Date: 14/11/2020 20:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   PROCEDURE [dbo].[SPInsertarPersona]
		 @pIdTipoDocumentoIdentidad INT
		,@pNombre VARCHAR
		,@pValorDocumentoIdentidad INT
		,@pFechaNacimiento DATE
		,@pTelefono1 VARCHAR
		,@pTelefono2 VARCHAR
		,@pCorreoElectronico VARCHAR

AS 
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		INSERT 
		INTO [dbo].[Persona]
						(
							 IdTipoDocumentoIdentidad
							,Nombre
							,ValorDocumentoIdentidad
							,FechaNacimiento
							,Telefono1
							,Telefono2
							,CorreoElectronico
							,InsertAt
							,UpdateAt
							,InsertBy
							,UpdateBy
							,InsertIn
							,UpdateIn
						)

		VALUES(
				 @pIdTipoDocumentoIdentidad
				,@pNombre
				,@pValorDocumentoIdentidad
				,@pFechaNacimiento
				,@pTelefono1
				,@pTelefono2
				,@pCorreoElectronico
				,GETDATE()
				,GETDATE()
				,'DB Admin'
				,'DB Admin'
				,'Costa Rica'
				,'Costa Rica'
			);
	END TRY
	BEGIN CATCH
		PRINT  'Algo salió mal al insertar Persona.'
		RETURN @@ERROR * - 1;
	END CATCH
	SET NOCOUNT OFF;
END

--DROP PROCEDURE SPInsertarPersona;
GO
