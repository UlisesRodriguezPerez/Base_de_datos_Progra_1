USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  Trigger [dbo].[FirstEstadoCuenta]    Script Date: 30/11/2020 23:47:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER   TRIGGER [dbo].[FirstEstadoCuenta] ON [dbo].[CuentaAhorro]
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @idCuentaAhorro INT
	DECLARE @fechaInicio DATE
	DECLARE @fechaFinal DATE
	DECLARE @saldoInicial MONEY
	DECLARE @saldoFinal MONEY

	SELECT @idCuentaAhorro = Id FROM [CuentaAhorro]
	SELECT @fechaInicio = FechaCreacion FROM [CuentaAhorro] 
	SELECT @fechaFinal = DATEADD(MONTH,1,@fechaInicio);
	SELECT @saldoInicial = Saldo FROM [CuentaAhorro]
	SELECT @saldoFinal = Saldo FROM [CuentaAhorro]


	BEGIN TRY
		INSERT 
		INTO [dbo].[EstadoCuenta]
		(
			 IdCuentaDeAhorro
			,FechaInicio
			,FechaFinal
			,SaldoInicial
			,SaldoFinal
		)

		VALUES(
			 @idCuentaAhorro
			,@fechaInicio
			,@fechaFinal
			,@saldoInicial
			,@saldoFinal
			);
	END TRY
	BEGIN CATCH
		PRINT  'Algo salió mal al insertar estado de cuenta.'

	END CATCH
	SET NOCOUNT OFF;

END
--DECLARE @fecha  DATE 
--SELECT @fecha = '2017-12-28'
--DECLARE @Otra DATE
--SELEct @Otra = DATEADD(MONTH,1,@fecha);
--print(@otra)


