-- ==============================================================================
-- Author:		Natalia Vargas 
-- Create date: 19/10/2020
-- Description:	Insertar un beneficiario en la tabla [dbo].[Beneficiario]
-- ==============================================================================

USE [BD_TP1_Cuenta_De_Ahorros]
GO


CREATE   PROCEDURE [dbo].[SPInsertarBeneficiario]
		@pIdTipoParentezco INT,
		@pIdPersona INT,
		@pIdDeCuentaAhorro INT,
		@pPorcentaje INT

AS 
BEGIN
	INSERT 
	INTO [dbo].[Beneficiario]
					(
						IdTipoParentezco
						,IdPersona
						,IdCuentaDeAhorro
						,Porcentaje
						,Activo
						,InsertAt
						,UpdateAt
						,InsertBy
						,UpdateBy
						,InsertIn
						,UpdateIn
					)

	VALUES(
			 @pIdTipoParentezco
			,@pIdPersona
			,@pIdDeCuentaAhorro
			,@pPorcentaje
			,1
			,GETDATE()
			,GETDATE()
			,'DB Admin'
			,'DB Admin'
			,'Costa Rica'
			,'Costa Rica'
		);

END

--EXEC SPInsertarBeneficiario @pIdTipoParentezco=4,@pIdPersona=1,@pIdDeCuentaAhorro=1,@pPorcentaje=20;
--SELECT * FROM Persona
--SELECT * FROM Beneficiario
--SELECT * FROM CuentaAhorro
--DROP PROCEDURE SPInsertarBeneficiario;
GO
