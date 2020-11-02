USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  StoredProcedure [dbo].[SPBuscarUsuario]    Script Date: 2/11/2020 02:20:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE     PROCEDURE [dbo].[SPBuscarUsuario]
(      
   @ID int      
)      
AS
BEGIN      
   SELECT 
		 ID
		,Nombre
		,Password
		,EsAdministrador
	FROM 
		[dbo].Usuario 
	WHERE 
		ID=@ID     
END
GO
