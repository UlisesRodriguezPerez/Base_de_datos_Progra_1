USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  StoredProcedure [dbo].[SPInsertarBeneficiario]    Script Date: 26/10/2020 18:11:24 ******/
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
			,GETDATE()
			,GETDATE()
			,'A'
			,'A'
			,'A'
			,'A'
		);

END

GO
