USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  StoredProcedure [dbo].[SPActualizarBeneficiario]    Script Date: 2/11/2020 02:20:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SPActualizarBeneficiario]
@pIdPersona INT,
@pIdTipoParentezco INT,
@pPorcentaje INT

AS 
BEGIN 
--Esto es para saber si existe el IdTipoParentesco que se quiere cambiar en la tabla
	SELECT CAST(COUNT(*) AS BIT) 
	FROM 
		[Beneficiario] 
	WHERE 
		(IdPersona = @pIdPersona)
	If COUNT(*) = 1
		BEGIN TRANSACTION
		UPDATE Beneficiario
			SET 
				IdTipoParentezco = @pIdTipoParentezco,
				Porcentaje = @pPorcentaje 
			FROM 
				[dbo].[Beneficiario]
			WHERE 
				Beneficiario.[IdPersona] = @pIdPersona
		COMMIT TRANSACTION
	
END

--LLamar a ejecutar el SP
--EXEC SPActualizarBeneficiario @pIdPersona=1, @pIdTipoParentezco=5,@pPorcentaje=10;
--SELECT * FROM [dbo].[Beneficiario]
--SELECT * FROM [dbo].[Persona]
--DROP PROCEDURE SPActualizarBeneficiario
GO
