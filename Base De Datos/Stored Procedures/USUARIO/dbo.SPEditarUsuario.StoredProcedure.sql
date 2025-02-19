USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  StoredProcedure [dbo].[SPEditarUsuario]    Script Date: 4/12/2020 11:39:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER     procedure [dbo].[SPEditarUsuario]
 (      
	 @id int
	,@Nombre varchar(100)
	,@Password varchar(100)
	,@TipoUsuario BIT 
 )      
AS  
BEGIN       
	SET NOCOUNT ON;
	BEGIN TRY
	   Update 
			[dbo].Usuario
	   SET 
			 Nombre=@Nombre
			,Password=@Password
			,EsAdministrador=@TipoUsuario
	   WHERE 
			ID=@id      
	END TRY
	BEGIN CATCH
		PRINT  'Algo salió mal al editar usuario.'
		RETURN @@ERROR ;
	END CATCH
	SET NOCOUNT OFF;
END
