USE [BD_TP1_Cuenta_De_Ahorros]
GO
/****** Object:  UserDefinedTableType [dbo].[TableMovimientos]    Script Date: 5/12/2020 23:49:49 ******/
CREATE TYPE [dbo].[TableMovimientos] AS TABLE(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idTipoMovimiento] [int] NULL,
	[numeroCuenta] [int] NULL,
	[monto] [money] NULL,
	[fecha] [date] NULL,
	[descripcion] [varchar](100) NULL
)
GO
