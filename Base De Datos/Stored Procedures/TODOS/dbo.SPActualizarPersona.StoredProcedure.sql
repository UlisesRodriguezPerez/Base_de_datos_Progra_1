USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  StoredProcedure [dbo].[SPActualizarPersona]    Script Date: 14/11/2020 20:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SPActualizarPersona] 
(
	 @pIdPersona INT
	,@pNombre VARCHAR(40)
	,@pValorDocumentoIdentidad INT
	,@pFechaNacimiento DATE
	,@pTelefono1 VARCHAR(50)
	,@pTelefono2 VARCHAR(50)
	,@pCorreoElectronico VARCHAR(50)
)

AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY

	BEGIN TRANSACTION
		UPDATE [dbo].[Persona]
			SET 
					 Nombre =  @pNombre
					,ValorDocumentoIdentidad  = @pValorDocumentoIdentidad 
					,FechaNacimiento = @pFechaNacimiento
					,Telefono1 = @pTelefono1
					,Telefono2 = @pTelefono2
					,CorreoElectronico = @pCorreoElectronico

			WHERE 
				[Persona].[Id] = @pIdPersona;
	COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		PRINT 'No se actualizó'
	END CATCH

	SET NOCOUNT OFF
END
GO
