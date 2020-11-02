USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  StoredProcedure [dbo].[SPObtenerBeneficiariosCuenta]    Script Date: 2/11/2020 02:20:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SPObtenerBeneficiariosCuenta]
(
	@pIdCuentaDeAhorro INT
)
AS 
BEGIN
	SELECT 
		IdTipoParentezco
		,IdPersona
		,Porcentaje
	FROM [dbo].[Beneficiario]
	WHERE  
		IdCuentaDeAhorro = @pIdCuentaDeAhorro ;

END

--SELECT * FROM Beneficiario
--SELECT * FROM CuentaAhorro
--SELECT * FROM Persona
--DROP PROCEDURE SPObtenerBeneficiario;
--GO
--EXEC SPObtenerBeneficiariosCuenta 1;
GO
