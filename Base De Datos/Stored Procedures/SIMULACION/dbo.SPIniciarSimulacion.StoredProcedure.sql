USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  StoredProcedure [dbo].[SPRellenar_Tablas]    Script Date: 30/11/2020 17:28:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SPIniciarSimulacion]
AS
DECLARE	@return_value int

EXEC    @return_value = [dbo].[SPVaciar_Tablas]
EXEC	@return_value = [dbo].[SPCargar_Catalogos]
EXEC    @return_value = [dbo].[SPSimulacion]
--EXEC	@return_value = [dbo].[SPCargar_Operaciones]
		

SELECT	'Return Value' = @return_value


--SELECT * FROM Persona
--SELECT * FROM CuentaAhorro
--SELECT * FROM Beneficiario

  --DELETE FROM Persona
  --DELETE FROM CuentaAhorro
  --DELETE FROM Beneficiario