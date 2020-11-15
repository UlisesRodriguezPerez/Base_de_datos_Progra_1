USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  StoredProcedure [dbo].[SPMostrarUsuarios]    Script Date: 14/11/2020 20:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[SPMostrarUsuarios]
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SELECT 
				 ID
				,Nombre
				,Password
				,EsAdministrador
		FROM 
				[dbo].Usuario
	END TRY
	BEGIN CATCH
		PRINT  'Algo salió al mostrar usuarios.'
		RETURN @@ERROR * - 1;
	END CATCH
	SET NOCOUNT OFF;
END
GO
