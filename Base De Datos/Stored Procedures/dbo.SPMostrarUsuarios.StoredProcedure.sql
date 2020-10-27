USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  StoredProcedure [dbo].[SPMostrarUsuarios]    Script Date: 26/10/2020 18:11:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[SPMostrarUsuarios]
AS
BEGIN
	SELECT 
			 ID
			,Nombre
			,Password
			,EsAdministrador
	FROM 
			[dbo].Usuario
END
GO
