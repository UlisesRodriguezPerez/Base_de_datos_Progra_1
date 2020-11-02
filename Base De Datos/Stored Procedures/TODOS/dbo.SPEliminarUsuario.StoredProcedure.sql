USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  StoredProcedure [dbo].[SPEliminarUsuario]    Script Date: 2/11/2020 02:20:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE     PROCEDURE [dbo].[SPEliminarUsuario]
(
	@ID int
)
AS 
BEGIN 
	DELETE 
		FROM 
			[dbo].[Usuario]
		WHERE 
			@ID = Id
END 
GO
