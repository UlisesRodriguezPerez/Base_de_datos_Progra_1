USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  StoredProcedure [dbo].[SPObtenerBeneficiario]    Script Date: 26/10/2020 18:11:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SPObtenerBeneficiario]
@pIdPersona INT
AS 
BEGIN
	SELECT * FROM [dbo].[Beneficiario]
	WHERE  IdPersona = @pIdPersona;

END

--SELECT * FROM Beneficiario
--SELECT * FROM CuentaAhorro
--SELECT * FROM Persona
--DROP PROCEDURE SPObtenerBeneficiario;
--GO
--EXEC SPObtenerBeneficiario 1;
GO
