USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  StoredProcedure [dbo].[SPInsertarBeneficiario]    Script Date: 2/11/2020 02:20:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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

--EXEC SPInsertarBeneficiario @pIdTipoParentezco=2,@pIdPersona=2,@pIdDeCuentaAhorro=1,@pPorcentaje=90,@pActivo=1;
--SELECT * FROM Beneficiario
--DROP PROCEDURE SPInsertarBeneficiario;
GO
