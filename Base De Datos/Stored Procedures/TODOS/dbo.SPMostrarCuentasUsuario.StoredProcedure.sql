USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  StoredProcedure [dbo].[SPMostrarCuentasUsuario]    Script Date: 5/12/2020 23:48:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE       PROCEDURE [dbo].[SPMostrarCuentasUsuario]   
(
	@id int
)
AS
BEGIN      
	SET NOCOUNT ON;
	BEGIN TRY
	   SELECT DISTINCT
			 CA.Id
			,IdTipoCuenta
			,IdPersona
			,NumeroDeCuenta
			,Saldo
			,FechaCreacion
			,U.Nombre
			,TC.Nombre
			,@id
		
		FROM 
			[dbo].[CuentaAhorro] CA
		INNER JOIN UsuarioPuedeAccesar UPA ON UPA.IdCuentaDeAhorros = CA.Id
		INNER JOIN Usuario U ON UPA.IdUsuario = U.id
		INNER JOIN TipoCuentaAhorro TC ON CA.IdTipoCuenta = TC.Id
		WHERE 
			UPA.IdUsuario = @id
	END TRY
	BEGIN CATCH
		EXEC [dbo].[SPManejoDeErrores] @ErrorLogId = 0 ,@CodigoDeError = 50036, @Descripcion = 'ERROR AL mostrar las cuentas de UPA(Usuario puede accesar) ([dbo].[SPMostrarCuentasUsuario])'
		PRINT  'Algo salió mal al mostrar cuentas usuario.'
		RETURN @@ERROR;
	END CATCH
	SET NOCOUNT OFF;
END
GO
