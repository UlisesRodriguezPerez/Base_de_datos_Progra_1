USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  Table [dbo].[CuentaAhorro]    Script Date: 26/10/2020 18:10:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CuentaAhorro](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdTipoCuenta] [int] NOT NULL,
	[IdPersona] [int] NOT NULL,
	[IdCuentaObjetivo] [int] NULL,
	[NumeroDeCuenta] [int] NOT NULL,
	[Saldo] [money] NOT NULL,
	[FechaCreacion] [date] NOT NULL,
	[InsertAt] [datetime] NULL,
	[UpdateAt] [datetime] NULL,
	[InsertBy] [varchar](50) NULL,
	[UpdateBy] [varchar](50) NULL,
	[InsertIn] [varchar](50) NULL,
	[UpdateIn] [varchar](50) NULL,
 CONSTRAINT [PK_CuentaAhorro] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CuentaAhorro]  WITH CHECK ADD  CONSTRAINT [FK_CuentaAhorro_Persona1] FOREIGN KEY([IdPersona])
REFERENCES [dbo].[Persona] ([Id])
GO
ALTER TABLE [dbo].[CuentaAhorro] CHECK CONSTRAINT [FK_CuentaAhorro_Persona1]
GO
ALTER TABLE [dbo].[CuentaAhorro]  WITH CHECK ADD  CONSTRAINT [FK_CuentaAhorro_TipoCuentaAhorro1] FOREIGN KEY([IdTipoCuenta])
REFERENCES [dbo].[TipoCuentaAhorro] ([Id])
GO
ALTER TABLE [dbo].[CuentaAhorro] CHECK CONSTRAINT [FK_CuentaAhorro_TipoCuentaAhorro1]
GO
