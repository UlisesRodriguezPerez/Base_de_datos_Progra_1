USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  StoredProcedure [dbo].[SPBeneficiario]    Script Date: 19/10/2020 12:40:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SPBeneficiario]
@pIdTipoParentezco INT,
@pPorcentaje INT
--@pFechaNacimiento DATE,
--@pValorDocumentoIdentidad,
--@pCorreoElectronico,
--@pTelefono1,
--@pTelefono2

AS 
BEGIN 
--Esto es para saber si existe el IdTipoParentesco que se quiere cambiar en la tabla
	SELECT CAST(COUNT(*) AS BIT) FROM [Beneficiario] WHERE (IdTipoParentezco = @pIdTipoParentezco)
	If COUNT(*) = 1
		BEGIN TRANSACTION
		UPDATE Beneficiario
			SET 
			IdTipoParentezco = @pIdTipoParentezco,
			Porcentaje = @pPorcentaje 
			FROM [dbo].[Beneficiario]
			WHERE Beneficiario.[Id] = 1
		COMMIT TRANSACTION
	
END
GO
