USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  StoredProcedure [dbo].[SPBuscarCuentaAhorro]    Script Date: 14/11/2020 20:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  	PROCEDURE [dbo].[SPBuscarCuentaAhorro]
(      
   @Id	INT 
)      
AS
BEGIN     
	SET NOCOUNT ON;
	BEGIN TRY
	   SELECT 
			 Id
			,IdTipoCuenta
			,IdPersona
			,NumeroDeCuenta
			,Saldo
			,FechaCreacion
		FROM 
			[dbo].[CuentaAhorro]
		WHERE 
			Id = @Id
	END TRY
	BEGIN CATCH
		PRINT  'Algo salió mal con buscar cuenta de ahorro.'
		RETURN @@ERROR * - 1;
	END CATCH
	SET NOCOUNT OFF;
END
GO
