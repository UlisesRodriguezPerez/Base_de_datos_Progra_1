USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  StoredProcedure [dbo].[SPBuscarEstadoCuenta]    Script Date: 14/11/2020 20:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE	PROCEDURE [dbo].[SPBuscarEstadoCuenta]
(      
	@pId	INT 
)      
AS
BEGIN 
	SET NOCOUNT ON;
	BEGIN TRY
	   SELECT 
			 IdCuentaDeAhorro
			,FechaInicio
			,FechaFinal
			,SaldoInicial
			,SaldoFinal

		FROM 
			[dbo].[EstadoCuenta]
		WHERE 
			Id=@pId  
	END TRY
	BEGIN CATCH
		PRINT  'Algo salió mal con buscar estado de cuenta.'
		RETURN @@ERROR * - 1;
	END CATCH
	SET NOCOUNT OFF;
END
GO
