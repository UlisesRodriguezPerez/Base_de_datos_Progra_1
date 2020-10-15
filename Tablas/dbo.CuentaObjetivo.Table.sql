USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  Table [dbo].[CuentaObjetivo]    Script Date: 14/10/2020 23:24:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CuentaObjetivo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdMovimientoCuentaObjetivo] [int] NOT NULL,
	[IdMovimientoCuentaObjetivoInteres] [int] NOT NULL,
	[FechaInicio] [date] NOT NULL,
	[FechaFinal] [date] NOT NULL,
	[Objetivo] [varchar](100) NOT NULL,
	[Saldo] [money] NOT NULL,
	[InteresAcumulado] [money] NOT NULL
) ON [PRIMARY]
GO
