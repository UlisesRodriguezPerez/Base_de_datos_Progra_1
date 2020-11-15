USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  StoredProcedure [dbo].[SPActualizarBeneficiario]    Script Date: 14/11/2020 20:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[SPActualizarBeneficiario]
	(
	   	 @pIdBeneficiario INT
		,@pIdPersona INT
		,@pParentezco VARCHAR(100)
		--,@pIdTipoParentezco INT
		,@pIdCuenta INT
		,@pPorcentaje INT
		
	)
AS 
BEGIN    
	SET NOCOUNT ON;
	BEGIN TRY
		--DECLARE  @pIDCuentaAhorro INT =
		DECLARE @pIdTipoParentezco INT

		DECLARE @Suma INT;
		DECLARE @Diferencia INT;
		DECLARE @Actual INT;


		SELECT 
			@pIdTipoParentezco = Id 
		FROM 
			[dbo].[TipoParentezco] 
		WHERE 
			Nombre = @pParentezco;
		SELECT 
			@Actual = Porcentaje 
		FROM 
			[dbo].[Beneficiario] 
		WHERE 
			Id = @pIdBeneficiario;
		SELECT 
			@Diferencia = @pPorcentaje - @Actual; 
		SELECT 
			@Suma = SUM(Porcentaje) 
		FROM 
			[dbo].[Beneficiario] 
		WHERE 
			IdCuentaDeAhorro = @pIdCuenta AND Activo = 1;
		IF @Suma + @Diferencia < 101
			BEGIN
			   Update 
					[dbo].Beneficiario
			   SET		

					 IdTipoParentezco = @pIdTipoParentezco
					,Porcentaje = @pPorcentaje

		
			   WHERE 
					ID = @pIdBeneficiario 
		
			END
		ELSE
			BEGIN
				PRINT 'SE EXCEDE DEL LÍMITE.'
				PRINT @Suma + @Diferencia
				PRINT @pIdTipoParentezco
				PRINT @pParentezco
			END
	END TRY
	BEGIN CATCH
		PRINT  'Algo salió mal al actualizar el beneficiario.'
		RETURN @@ERROR * - 1;
	END CATCH
	SET NOCOUNT OFF;
		--AND IdPersona = @pIdPersona





--EXEC [dbo].[SPActualizarBeneficiario] 
--@pIdBeneficiario = 1
--,@pIdPersona = 1
--,@pIdTipoParentezco =1
--	,@pIdCuenta = 1
--	,@pPorcentaje= 50
--BEGIN 
----Esto es para saber si existe el IdTipoParentesco que se quiere cambiar en la tabla
--	SELECT CAST(COUNT(*) AS BIT) 
--	FROM 
--		[Beneficiario] 
--	WHERE 
--		(IdPersona = @pIdPersona) AND (Id = @pIdBeneficiario)
--	If COUNT(*) = 1
--		BEGIN TRANSACTION
--		UPDATE Beneficiario
--			SET 
--				IdTipoParentezco = @pIdTipoParentezco,
--				Porcentaje = @pPorcentaje 
--			FROM 
--				[dbo].[Beneficiario]
--			WHERE 
--				Beneficiario.[IdPersona] = @pIdPersona
--		COMMIT TRANSACTION
	
END

------LLamar a ejecutar el SP
--EXEC SPActualizarBeneficiario @pIdBeneficiario = 1, @pIdPersona=1
--		, @pParentezco = 'Madre', @pIdCuenta = 1,@pPorcentaje=95;



		
GO
