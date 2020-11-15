USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  StoredProcedure [dbo].[SPActualizarEstadoCuenta]    Script Date: 14/11/2020 20:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SPActualizarEstadoCuenta]
(		
		 @pId INT
		,@pFechaFinal DATE
		,@pSaldoFinal MONEY
)

AS 
BEGIN 
	SET NOCOUNT ON;
	BEGIN TRY
	   Update 
			[dbo].[EstadoCuenta]
	   SET 
			 FechaFinal = @pFechaFinal
			,SaldoFinal = @pSaldoFinal

	   WHERE 
			Id=@pId   
	END TRY
	BEGIN CATCH
		PRINT  'Algo salió mal con el SP de actualizar estado de cuenta.'
		RETURN @@ERROR * - 1;
	END CATCH
	SET NOCOUNT OFF;
END


--EXEC SPActualizarEstadoCuenta 2020-11-12,145000000;
--SELECT * FROM [dbo].[EstadoCuenta]
--DROP PROCEDURE SPActualizarEstadoCuenta;
GO
