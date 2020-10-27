USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  StoredProcedure [dbo].[SPRellenar_Tablas]    Script Date: 26/10/2020 18:11:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SPRellenar_Tablas]
AS
DECLARE	@return_value int

EXEC    @return_value = [dbo].[SPVaciar_Tablas]
EXEC	@return_value = [dbo].[SPCargar_Catalogos]
EXEC	@return_value = [dbo].[SPCargar_Operaciones]
		

SELECT	'Return Value' = @return_value
GO
