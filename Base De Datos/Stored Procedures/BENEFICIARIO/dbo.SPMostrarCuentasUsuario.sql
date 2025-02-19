USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  StoredProcedure [dbo].[SPMostrarCuentasUsuario]    Script Date: 10/11/2020 18:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER       PROCEDURE [dbo].[SPMostrarCuentasUsuario]   
(
	@id int
)
AS
BEGIN      
   SELECT 
		 @id
		,IdTipoCuenta
		,IdPersona
		,NumeroDeCuenta
		,Saldo
		,FechaCreacion
		,U.Nombre
		,TC.Nombre
		
	FROM 
		[dbo].[CuentaAhorro] CA
	INNER JOIN UsuarioPuedeAccesar UPA ON UPA.IdCuentaDeAhorros = CA.Id
	INNER JOIN Usuario U ON UPA.Id = U.id
	INNER JOIN TipoCuentaAhorro TC ON CA.IdTipoCuenta = TC.Id
	WHERE 
		UPA.IdUsuario = @id

END
