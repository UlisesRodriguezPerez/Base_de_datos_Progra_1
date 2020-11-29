USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  StoredProcedure [dbo].[SPObtenerEstadosCuenta]    Script Date: 28/11/2020 18:10:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER	PROCEDURE [dbo].[SPObtenerEstadosCuenta]
(      
   @pIdCuentaDeAhorro	INT 
)      
AS

BEGIN   
	SET NOCOUNT ON;
	BEGIN TRY
	   SELECT 
		--TOP 8
			 EC.Id
			,EC.IdCuentaDeAhorro
			,EC.FechaInicio
			,EC.FechaFinal
			,EC.SaldoInicial
			,EC.SaldoFinal
			,CA.NumeroDeCuenta

		FROM 
			[dbo].[EstadoCuenta] EC
			INNER JOIN CuentaAhorro CA ON EC.IdCuentaDeAhorro = CA.Id
		WHERE 

			IdCuentaDeAhorro=@pIdCuentaDeAhorro  
	
		ORDER BY FechaFinal DESC 
	END TRY
	BEGIN CATCH
		PRINT  'Algo salió mal al obtener estados de cuenta.'
		RETURN @@ERROR ;
	END CATCH
	SET NOCOUNT OFF;
	
END


--EXEC [SPObtenerEstadosCuenta] @pIdCuentaDeAhorro = 1
