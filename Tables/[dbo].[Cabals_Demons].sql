/****** Object:  Table [dbo].[Cabals_Demons]    Script Date: 10/15/2021 4:47:39 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Cabals_Demons](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CabalId] [int] NOT NULL,
	[DemonId] [int] NOT NULL,
 CONSTRAINT [PK_Cabals_Demons] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO