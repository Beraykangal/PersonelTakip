USE [master]
GO
/****** Object:  Database [PersonelTakip]    Script Date: 16.08.2024 15:07:12 ******/
CREATE DATABASE [PersonelTakip]
GO
ALTER DATABASE [PersonelTakip] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PersonelTakip].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PersonelTakip] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PersonelTakip] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PersonelTakip] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PersonelTakip] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PersonelTakip] SET ARITHABORT OFF 
GO
ALTER DATABASE [PersonelTakip] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PersonelTakip] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PersonelTakip] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PersonelTakip] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PersonelTakip] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PersonelTakip] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PersonelTakip] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PersonelTakip] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PersonelTakip] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PersonelTakip] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PersonelTakip] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PersonelTakip] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PersonelTakip] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PersonelTakip] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PersonelTakip] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PersonelTakip] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PersonelTakip] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PersonelTakip] SET RECOVERY FULL 
GO
ALTER DATABASE [PersonelTakip] SET  MULTI_USER 
GO
ALTER DATABASE [PersonelTakip] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PersonelTakip] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PersonelTakip] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PersonelTakip] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PersonelTakip] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PersonelTakip] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'PersonelTakip', N'ON'
GO
ALTER DATABASE [PersonelTakip] SET QUERY_STORE = ON
GO
ALTER DATABASE [PersonelTakip] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [PersonelTakip]
GO
/****** Object:  Table [dbo].[Kullanicilar]    Script Date: 16.08.2024 15:07:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kullanicilar](
	[pkKullanici] [int] IDENTITY(1,1) NOT NULL,
	[KullaniciAdi] [nvarchar](50) NOT NULL,
	[Sifre] [nvarchar](50) NOT NULL,
	[Ad] [nvarchar](50) NULL,
	[Soyad] [nvarchar](50) NULL,
	[OlusturulmaTarihi] [datetime] NULL,
	[DuzenlenmeTarihi] [datetime] NULL,
	[EPosta] [nvarchar](50) NULL,
	[Telefon] [nvarchar](50) NULL,
	[SifreDegistir] [bit] NULL,
	[fkYetki] [int] NULL,
 CONSTRAINT [PK_Kullanicilar] PRIMARY KEY CLUSTERED 
(
	[pkKullanici] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MezuniyetDurumlari]    Script Date: 16.08.2024 15:07:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MezuniyetDurumlari](
	[pkMezuniyetDurumu] [int] IDENTITY(1,1) NOT NULL,
	[MezuniyetAciklamasi] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_MezuniyetDurumlari] PRIMARY KEY CLUSTERED 
(
	[pkMezuniyetDurumu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Personeller]    Script Date: 16.08.2024 15:07:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Personeller](
	[pkPersonel] [int] IDENTITY(1,1) NOT NULL,
	[Ad] [nvarchar](50) NOT NULL,
	[Soyad] [nvarchar](50) NOT NULL,
	[Cinsiyet] [char](1) NULL,
	[ZimmetBilgileri] [nvarchar](100) NULL,
	[fkMezuniyetDurumu] [int] NULL,
	[Universite] [nvarchar](100) NULL,
	[OlusturulmaTarihi] [datetime] NULL,
	[DuzenlenmeTarihi] [datetime] NULL,
 CONSTRAINT [PK_Personeller] PRIMARY KEY CLUSTERED 
(
	[pkPersonel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Yetkiler]    Script Date: 16.08.2024 15:07:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Yetkiler](
	[pkYetki] [int] IDENTITY(1,1) NOT NULL,
	[YetkiAciklamasi] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Yetkiler] PRIMARY KEY CLUSTERED 
(
	[pkYetki] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Kullanicilar] ON 

INSERT [dbo].[Kullanicilar] ([pkKullanici], [KullaniciAdi], [Sifre], [Ad], [Soyad], [OlusturulmaTarihi], [DuzenlenmeTarihi], [EPosta], [Telefon], [SifreDegistir], [fkYetki]) VALUES (23, N'admin', N'e10adc3949ba59abbe56e057f20f883e', N'admin', N'admin', NULL, NULL, N'', N'', 0, 1)
SET IDENTITY_INSERT [dbo].[Kullanicilar] OFF
GO
SET IDENTITY_INSERT [dbo].[MezuniyetDurumlari] ON 

INSERT [dbo].[MezuniyetDurumlari] ([pkMezuniyetDurumu], [MezuniyetAciklamasi]) VALUES (1, N'Önlisans')
INSERT [dbo].[MezuniyetDurumlari] ([pkMezuniyetDurumu], [MezuniyetAciklamasi]) VALUES (2, N'Lisans')
INSERT [dbo].[MezuniyetDurumlari] ([pkMezuniyetDurumu], [MezuniyetAciklamasi]) VALUES (3, N'Yüksek Lisans')
SET IDENTITY_INSERT [dbo].[MezuniyetDurumlari] OFF
GO
SET IDENTITY_INSERT [dbo].[Personeller] ON 

INSERT [dbo].[Personeller] ([pkPersonel], [Ad], [Soyad], [Cinsiyet], [ZimmetBilgileri], [fkMezuniyetDurumu], [Universite], [OlusturulmaTarihi], [DuzenlenmeTarihi]) VALUES (3, N'Fatma Beray', N'Kangal', N'K', N'Laptop', 1, N'Maltepe University', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Personeller] OFF
GO
SET IDENTITY_INSERT [dbo].[Yetkiler] ON 

INSERT [dbo].[Yetkiler] ([pkYetki], [YetkiAciklamasi]) VALUES (1, N'Admin')
INSERT [dbo].[Yetkiler] ([pkYetki], [YetkiAciklamasi]) VALUES (2, N'Kullanıcı')
SET IDENTITY_INSERT [dbo].[Yetkiler] OFF
GO
USE [master]
GO
ALTER DATABASE [PersonelTakip] SET  READ_WRITE 
GO
