USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  StoredProcedure [dbo].[SPValidarUsuario]    Script Date: 14/11/2020 20:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- SP para verificar usuarios

CREATE  
	PROCEDURE 
		[dbo].[SPValidarUsuario]
			(      
				@Nombre varchar(100),
				@Password varchar(100)
			)      
AS       
BEGIN     
	SET NOCOUNT ON;
	BEGIN TRY
	   SELECT 
			 Id
			,Nombre
			,Password
			,EsAdministrador 
		FROM 
			[dbo].Usuario 
		WHERE 
				Nombre=@Nombre 
			AND 
				Password=@Password 
	END TRY
	BEGIN CATCH
		PRINT  'Algo salió mal al validar al usuario.'
		RETURN @@ERROR * - 1;
	END CATCH
	SET NOCOUNT OFF;
END
GO
