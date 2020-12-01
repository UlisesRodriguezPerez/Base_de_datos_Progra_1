USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  StoredProcedure [dbo].[SPInsertarMovimientoSimulacion]    Script Date: 30/11/2020 20:29:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER  PROCEDURE [dbo].[SPInsertarMovimientoSimulacion]
		@TablaMovimientoAux [dbo].[TableMovimientos] READONLY
		 --@idTipoMovimiento INT
		--,@numeroCuenta INT
		----,@idCuentaAhorro INT
		----,@idEstadoCuenta INT
		--,@monto MONEY
		--,@fecha DATETIME
		--,@descripcion VARCHAR(100)

AS 
BEGIN -- <Movimientos Tipo="5" CodigoCuenta="11895861" Monto="44438091.00" Descripcion="Banco Central" />

	DECLARE @idTipoMovimiento INT
	DECLARE @numeroCuenta INT
	DECLARE @monto MONEY
	DECLARE @fecha DATETIME
	DECLARE @descripcion VARCHAR(100)

	SELECT @idTipoMovimiento = idTipoMovimiento FROM @TablaMovimientoAux
	SELECT @numeroCuenta = numeroCuenta FROM @TablaMovimientoAux
	SELECT @monto = monto FROM @TablaMovimientoAux
	SELECT @fecha = fecha FROM @TablaMovimientoAux
	SELECT @descripcion = descripcion FROM @TablaMovimientoAux

	SET NOCOUNT ON;
	BEGIN TRY
		
		DECLARE @idDeCuentaAhorro INT
		DECLARE @idEstadoCuenta INT
		SELECT @idDeCuentaAhorro = Id FROM [dbo].[CuentaAhorro] WHERE NumeroDeCuenta = @numeroCuenta;
		SELECT @idEstadoCuenta = Id FROM [dbo].[EstadoCuenta] WHERE IdCuentaDeAhorro = @idDeCuentaAhorro;
		

		-- En caso de ser Debito se le resta a la CA, de lo contrario se le suma.
		IF @idTipoMovimiento < 4
			BEGIN
				Update 
					[dbo].[CuentaAhorro]
				SET		
					Saldo = Saldo - @monto
				WHERE 
					Id = @idDeCuentaAhorro
			END
		ELSE
			BEGIN
				Update 
					[dbo].[CuentaAhorro]
				SET		
					Saldo = Saldo + @monto
				WHERE 
					Id = @idDeCuentaAhorro
			END

		INSERT 
		INTO [dbo].[Movimiento]
		(
			 IdTipoMovimiento
			,IdCuentaAhorro
			,IdEstadoDeCuenta
			,Monto
			,Fecha
			,Descripcion
		)
		VALUES(
			 @idTipoMovimiento
			,@idDeCuentaAhorro
			,@idEstadoCuenta
			,@monto
			,@fecha
			,@descripcion
			);
		
	END TRY
	BEGIN CATCH
		PRINT  'Algo salió mal al INSERTAR Movimiento.'
		RETURN @@ERROR;
	END CATCH
	SET NOCOUNT OFF;
END


