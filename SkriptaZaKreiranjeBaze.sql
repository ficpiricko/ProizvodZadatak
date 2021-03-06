  
IF NOT EXISTS (
        SELECT *
        FROM sys.databases
        WHERE name = 'Proizvodi'
        )
BEGIN
    CREATE DATABASE [Proizvodi]
END
GO
USE [Proizvodi]
GO
/****** Object:  Table [dbo].[Proizvod]    Script Date: 5/22/2020 9:47:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Proizvod]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Proizvod](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Naziv] [nvarchar](50) NULL,
	[Opis] [nvarchar](50) NULL,
	[Kategorija] [nvarchar](50) NULL,
	[Proizvodjac] [nvarchar](50) NULL,
	[Dobavljac] [nvarchar](50) NULL,
	[Cena] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Proizvodi] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[Proizvod] ON 

INSERT [dbo].[Proizvod] ([ID], [Naziv], [Opis], [Kategorija], [Proizvodjac], [Dobavljac], [Cena]) VALUES (1, N'PC', N'Gaming racunar', N'Kucni racunar', N'DELL', N'Gigatron', CAST(26000.00 AS Decimal(18, 2)))
INSERT [dbo].[Proizvod] ([ID], [Naziv], [Opis], [Kategorija], [Proizvodjac], [Dobavljac], [Cena]) VALUES (2, N'PC', N'Gaming racunar', N'Kucni racunar', N'DELL', N'Gigatron', CAST(2500.00 AS Decimal(18, 2)))
INSERT [dbo].[Proizvod] ([ID], [Naziv], [Opis], [Kategorija], [Proizvodjac], [Dobavljac], [Cena]) VALUES (3, N'Laptop', N'Kucni racunar', N'Racunari', N'Asus', N'Gigatron', CAST(50950.00 AS Decimal(18, 2)))
INSERT [dbo].[Proizvod] ([ID], [Naziv], [Opis], [Kategorija], [Proizvodjac], [Dobavljac], [Cena]) VALUES (4, N'Dzojstik', N'Gaming', N'Gaming oprema', N'Sony', N'Gigatron', CAST(600.00 AS Decimal(18, 2)))
INSERT [dbo].[Proizvod] ([ID], [Naziv], [Opis], [Kategorija], [Proizvodjac], [Dobavljac], [Cena]) VALUES (5, N'Slusalice Dr Dre', N'Slusalice bezicne', N'SLUSALICE', N'Dr dre', N'Alti', CAST(20000.00 AS Decimal(18, 2)))
INSERT [dbo].[Proizvod] ([ID], [Naziv], [Opis], [Kategorija], [Proizvodjac], [Dobavljac], [Cena]) VALUES (6, N'Slusalice Dr Dre', N'Slusalice bezicne', N'SLUSALICE', N'Dr dre', N'Alti', CAST(22000.00 AS Decimal(18, 2)))
INSERT [dbo].[Proizvod] ([ID], [Naziv], [Opis], [Kategorija], [Proizvodjac], [Dobavljac], [Cena]) VALUES (12, N'Wi-fi antena', N'Wi-fi antena', N'Wi-fi uredjaj', N'TP-Link', N'Gigatron', CAST(2550.00 AS Decimal(18, 2)))
INSERT [dbo].[Proizvod] ([ID], [Naziv], [Opis], [Kategorija], [Proizvodjac], [Dobavljac], [Cena]) VALUES (13, N'Podmetac za mis', N'Mis podmetac', N'Oprema racunarska', N'/', N'Alti', CAST(450.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[Proizvod] OFF
/****** Object:  StoredProcedure [dbo].[DodajProizvod]    Script Date: 5/22/2020 9:47:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DodajProizvod]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DodajProizvod] AS' 
END
GO
ALTER Procedure [dbo].[DodajProizvod]  
(  
   @Naziv nvarchar (50),  
   @Opis nvarchar (50),  
   @Kategorija nvarchar (100),
   @Proizvodjac nvarchar (100)  ,
   @Dobavljac nvarchar (100)  ,
   @Cena decimal (18,2)  
)  
as  
begin  
    Insert into Proizvod values(@Naziv,@Opis,@Kategorija,@Proizvodjac,@Dobavljac,@Cena)  
End
GO
/****** Object:  StoredProcedure [dbo].[UpdateProizvoda]    Script Date: 5/22/2020 9:47:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateProizvoda]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[UpdateProizvoda] AS' 
END
GO
ALTER Procedure [dbo].[UpdateProizvoda]  
(  
   @ID int,  
   @Naziv nvarchar (50),  
   @Opis nvarchar (50),  
   @Kategorija nvarchar (100),
   @Proizvodjac nvarchar (100)  ,
   @Dobavljac nvarchar (100)  ,
   @Cena decimal (18,2)  
)  
as  
begin  
   Update Proizvod   
   set Naziv=@Naziv,  
   Opis=@Opis,  
   Kategorija=@Kategorija  ,
   Proizvodjac = @Proizvodjac,
   Dobavljac = @Dobavljac,
   Cena = @Cena
   where ID=@ID  
End
GO
/****** Object:  StoredProcedure [dbo].[VratiProizvode]    Script Date: 5/22/2020 9:47:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VratiProizvode]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[VratiProizvode] AS' 
END
GO
ALTER Procedure [dbo].[VratiProizvode]  
	
AS
BEGIN
	SELECT * from Proizvod
END
GO
