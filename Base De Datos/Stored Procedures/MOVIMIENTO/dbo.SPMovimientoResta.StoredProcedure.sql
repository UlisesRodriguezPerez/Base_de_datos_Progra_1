USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  StoredProcedure [dbo].[SPMovimientoResta]    Script Date: 5/12/2020 20:40:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER    PROCEDURE [dbo].[SPMovimientoResta]
		@monto MONEY
		,@idDeCuentaAhorro INT


AS 
BEGIN 
	BEGIN TRY
		SET NOCOUNT ON;
		BEGIN TRANSACTION 
		Update 
			[dbo].[CuentaAhorro]
		SET		
			Saldo = Saldo - @monto
		WHERE 
			Id = @idDeCuentaAhorro

		UPDATE
			EstadoCuenta
		SET 
			SaldoFinal = SaldoFinal - @monto
		WHERE 
			IdCuentaDeAhorro = @idDeCuentaAhorro


		COMMIT TRANSACTION
		SET NOCOUNT OFF;
	END TRY
	BEGIN CATCH
		PRINT  'Algo salió mal al realizar la resta.'
		RETURN @@ERROR;
	END CATCH
END


