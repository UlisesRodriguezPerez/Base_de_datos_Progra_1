USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  StoredProcedure [dbo].[SPBuscarUsuario]    Script Date: 14/11/2020 20:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE	PROCEDURE [dbo].[SPBuscarUsuario]
(      
   @pValorDocumentoIdentidad	INT 
)      
AS
BEGIN  
	SET NOCOUNT ON;
	BEGIN TRY
	   SELECT 
			 [Nombre]
			,[FechaNacimiento]
			,[Telefono1]
			,[Telefono2]
			,[CorreoElectronico]
		FROM 
			[dbo].[Persona]
		WHERE 
			ValorDocumentoIdentidad=@pValorDocumentoIdentidad    
	END TRY
	BEGIN CATCH
		PRINT  'Algo salió mal al buscar usuario.'
		RETURN @@ERROR * - 1;
	END CATCH
	SET NOCOUNT OFF;
END
GO
