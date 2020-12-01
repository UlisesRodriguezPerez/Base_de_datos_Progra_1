USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  StoredProcedure [dbo].[SPInsertarCuentasAhorroSimulacion]    Script Date: 1/12/2020 03:20:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER    PROCEDURE [dbo].[SPInsertarCuentasAhorroSimulacion]
		@tablaCuentasAhorro [dbo].[CuentaAhorroPerTrigger] READONLY
			
			--	 [IdPersona]
			--	,[IdTipoCuenta]
			--	,[NumeroDeCuenta]
			--	,[FechaCreacion]
			--	,[Saldo]
			--  ,[InsertAt]
			--	,[UpdateAt]
			--	,[InsertBy]
			--	,[UpdateBy]
			--	,[InsertIn]
			--	,[UpdateIn]

AS 
BEGIN -- <Movimientos Tipo="5" CodigoCuenta="11895861" Monto="44438091.00" Descripcion="Banco Central" />
	


	DECLARE @idMenor INT
	DECLARE @idMayor INT

	DECLARE @idDeCuentaAhorro INT
	DECLARE @idEstadoCuenta INT

	DECLARE @idPersona INT
	DECLARE @idTipoCuenta INT
	DECLARE @numeroCuenta INT
	DECLARE @fechaCreacion DATE
	DECLARE @saldo MONEY
	
	

	SET NOCOUNT ON;
	--BEGIN TRY
		--BEGIN TRANSACTION
		SELECT @idMenor = min([id]), @idMayor=max([id]) FROM @tablaCuentasAhorro
		WHILE @idMenor <= @idMayor
			BEGIN
				SELECT @idPersona = idPersona FROM @tablaCuentasAhorro WHERE id = @idMenor
				SELECT @idTipoCuenta = idTipoCuenta FROM @tablaCuentasAhorro WHERE id = @idMenor
				SELECT @numeroCuenta = numeroCuenta FROM @tablaCuentasAhorro WHERE id = @idMenor
				SELECT @fechaCreacion = fechaCreacion FROM @tablaCuentasAhorro WHERE id = @idMenor
				SELECT @saldo = saldo FROM @tablaCuentasAhorro WHERE id = @idMenor

				INSERT CuentaAhorro
					(
						 IdPersona
						,[IdTipoCuenta]
						,[NumeroDeCuenta]
						,[FechaCreacion]
						,[Saldo]
						,[InsertAt]
						,[UpdateAt]
						,[InsertBy]
						,[UpdateBy]
						,[InsertIn]
						,[UpdateIn]
					)
				VALUES
					(
						 @idPersona
						,@idTipoCuenta
						,@numeroCuenta
						,@fechaCreacion
						,@saldo
						,@fechaCreacion
						,null
						,'CURRENT_USER' 
						,null
						,'DESKTOP-FBGDAQE'
						,null
					);
		

				SET @idMenor = @idMenor + 1
			END
		--	SELECT * FROM @tablaCuentasAhorro

		--COMMIT TRANSACTION
	--END TRY
	--BEGIN CATCH
	--	PRINT  'Algo salió mal al INSERTAR Movimiento.'
	--	RETURN @@ERROR;
	--END CATCH
	SET NOCOUNT OFF;
	
END


