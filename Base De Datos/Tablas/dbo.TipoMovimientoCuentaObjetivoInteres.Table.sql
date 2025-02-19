USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  Table [dbo].[TipoMovimientoCuentaObjetivoInteres]    Script Date: 26/10/2020 18:10:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoMovimientoCuentaObjetivoInteres](
	[Id] [int] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TipoMovimientoCuentaObjetivoInteres] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
