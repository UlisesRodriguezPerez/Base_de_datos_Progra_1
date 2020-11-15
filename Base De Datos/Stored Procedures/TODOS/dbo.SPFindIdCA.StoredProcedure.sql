USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  StoredProcedure [dbo].[SPFindIdCA]    Script Date: 14/11/2020 20:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  	PROCEDURE [dbo].[SPFindIdCA]
(      
   @pNumeroCuentaDeAhorro	INT 
)      
AS

BEGIN   
	SET NOCOUNT ON;
	BEGIN TRY
	   SELECT 
			 Id

		FROM 
			[dbo].[CuentaAhorro] 

		WHERE 

			NumeroDeCuenta = @pNumeroCuentaDeAhorro
	END TRY
	BEGIN CATCH
		PRINT  'Algo salió mal al buscar cuenta de ahorro.'
		RETURN @@ERROR * - 1;
	END CATCH
	SET NOCOUNT OFF;
	
END


--EXEC [SPObtenerEstadosCuenta] @pIdCuentaDeAhorro = 1
GO
