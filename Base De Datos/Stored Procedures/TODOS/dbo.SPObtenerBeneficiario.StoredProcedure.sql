USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  StoredProcedure [dbo].[SPObtenerBeneficiario]    Script Date: 2/11/2020 02:20:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SPObtenerBeneficiario]
(
	@pIdPersona INT
)
AS 
BEGIN
	SELECT 
		IdTipoParentezco
		,IdPersona
		,Porcentaje
	FROM [dbo].[Beneficiario]
	WHERE  
		IdPersona = @pIdPersona;

END
GO
