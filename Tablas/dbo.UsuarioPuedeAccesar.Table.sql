USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  Table [dbo].[UsuarioPuedeAccesar]    Script Date: 14/10/2020 23:24:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsuarioPuedeAccesar](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdCuentaDeAhorros] [int] NOT NULL,
	[IdUsuario] [int] NOT NULL,
	[Activo] [bit] NOT NULL,
	[InsertAt] [datetime] NOT NULL,
	[UpdateAt] [datetime] NOT NULL,
	[InsertBy] [varchar](50) NOT NULL,
	[UpdateBy] [varchar](50) NOT NULL,
	[InsertIn] [varchar](50) NOT NULL,
	[UpdateIn] [varchar](50) NOT NULL,
 CONSTRAINT [PK_UsuarioPuedeAccesar] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[UsuarioPuedeAccesar]  WITH CHECK ADD  CONSTRAINT [FK_UsuarioPuedeAccesar_CuentaAhorro] FOREIGN KEY([IdCuentaDeAhorros])
REFERENCES [dbo].[CuentaAhorro] ([Id])
GO
ALTER TABLE [dbo].[UsuarioPuedeAccesar] CHECK CONSTRAINT [FK_UsuarioPuedeAccesar_CuentaAhorro]
GO
ALTER TABLE [dbo].[UsuarioPuedeAccesar]  WITH CHECK ADD  CONSTRAINT [FK_UsuarioPuedeAccesar_Usuario] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[Usuario] ([Id])
GO
ALTER TABLE [dbo].[UsuarioPuedeAccesar] CHECK CONSTRAINT [FK_UsuarioPuedeAccesar_Usuario]
GO
