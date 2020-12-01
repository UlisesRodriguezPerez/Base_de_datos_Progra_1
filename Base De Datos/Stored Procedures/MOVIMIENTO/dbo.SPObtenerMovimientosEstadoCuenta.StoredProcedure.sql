USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  StoredProcedure [dbo].[SPObtenerMovimientosEstadoCuenta]    Script Date: 1/12/2020 04:03:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   PROCEDURE [dbo].[SPObtenerMovimientosEstadoCuenta]
(
	 --@idCuentaAhorro INT
	@idEstadoCuenta INT
)
AS 
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SELECT
			  M.Monto
			 ,M.Fecha
			 ,M.Descripcion
			 ,TM.Nombre
			 ,CA.Id
			 ,EC.Id
			 ,TM.Tipo
			 
		FROM [dbo].[Movimiento] M
		INNER JOIN CuentaAhorro CA ON M.IdCuentaAhorro = CA.Id
		INNER JOIN TipoMovimiento TM ON M.IdTipoMovimiento = TM.Id
		INNER JOIN EstadoCuenta EC ON M.IdEstadoDeCuenta = EC.Id
		WHERE  
				EC.Id = @idEstadoCuenta
			AND
				fecha BETWEEN EC.FechaInicio AND EC.FechaFinal
		ORDER BY Fecha DESC 
	END TRY
	BEGIN CATCH
		PRINT  'Algo salió mal al obtener los movimientos del estado de cuenta.'
		RETURN @@ERROR ;
	END CATCH
	SET NOCOUNT OFF;
END

--exec [SPObtenerMovimientosEstadoCuenta] @idEstadoCuenta = 0