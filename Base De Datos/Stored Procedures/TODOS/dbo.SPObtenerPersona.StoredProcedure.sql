USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  StoredProcedure [dbo].[SPObtenerPersona]    Script Date: 14/11/2020 20:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SPObtenerPersona]
(
	@pId INT
)
AS 
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SELECT 
			 Nombre
			,ValorDocumentoIdentidad
			,FechaNacimiento
			,Telefono1
			,Telefono2
			,CorreoElectronico

		FROM [dbo].[Persona]
		WHERE  
			Id = @pId;
	END TRY
	BEGIN CATCH
		PRINT  'Algo salió mal al obtener persona.'
		RETURN @@ERROR * - 1;
	END CATCH
	SET NOCOUNT OFF;
END

--SELECT * FROM Persona
--DROP PROCEDURE SPObtenerBeneficiario;
--GO
--EXEC SPObtenerPersona 20;
GO
