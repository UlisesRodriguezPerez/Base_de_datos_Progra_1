USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  StoredProcedure [dbo].[SPExisteBeneficiarioEnDB]    Script Date: 5/12/2020 23:48:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[SPExisteBeneficiarioEnDB]
(
		@pDocumentoIdentidadPersona VARCHAR(50)
			
)

AS 

BEGIN

BEGIN TRY
		DECLARE @pIdPersona INT
		DECLARE @outResultCode INT 
		SET @pIdPersona = 0;
		SET @outResultCode = 0;

		SELECT 
			@pIdPersona = Id 
		FROM 
			[dbo].[Persona] 
		WHERE 
			ValorDocumentoIdentidad = @pDocumentoIdentidadPersona;
		
		IF @pIdPersona = 0
			BEGIN
				PRINT  'No existe'
				SET @outResultCode = 50001;
				SELECT @outResultCode
			
			END
		ELSE
			BEGIN
				PRINT  'Existe'
				SELECT @pIdPersona
			END
	
	END TRY

	BEGIN CATCH
		EXEC [dbo].[SPManejoDeErrores] @ErrorLogId = 0 ,@CodigoDeError = 50026, @Descripcion = 'Error al verificar Beneficiario ([dbo].[SPExisteBeneficiarioEnDB])'
		PRINT  'Algo salió mal al insertar beneficiario.'
		RETURN @@ERROR ;
	END CATCH
	SET NOCOUNT OFF;
END


--SELECT * FROM [dbo].[Persona] 
--DROP PROC  SPExisteBeneficiarioEnDB

--EXEC SPExisteBeneficiarioEnDB @pDocumentoIdentidadPersona= 123244567;
GO
