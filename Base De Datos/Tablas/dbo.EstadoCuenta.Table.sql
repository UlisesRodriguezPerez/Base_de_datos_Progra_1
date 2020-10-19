USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  Table [dbo].[EstadoCuenta]    Script Date: 19/10/2020 09:05:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EstadoCuenta](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdCuentaDeAhorro] [int] NOT NULL,
	[FechaInicio] [date] NOT NULL,
	[FechaFinal] [date] NOT NULL,
	[SaldoInicial] [money] NOT NULL,
	[SaldoFinal] [money] NOT NULL,
 CONSTRAINT [PK_EstadoCuenta] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EstadoCuenta]  WITH CHECK ADD  CONSTRAINT [FK_EstadoCuenta_CuentaAhorro] FOREIGN KEY([IdCuentaDeAhorro])
REFERENCES [dbo].[CuentaAhorro] ([Id])
GO
ALTER TABLE [dbo].[EstadoCuenta] CHECK CONSTRAINT [FK_EstadoCuenta_CuentaAhorro]
GO
