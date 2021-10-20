SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Cabals_Demons](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CabalId] [int] NOT NULL,
	[DemonId] [int] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Cabals_Demons] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Cabals_Demons] ADD  CONSTRAINT [DF_Cabals_Demons_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO

ALTER TABLE [dbo].[Cabals_Demons] ADD  CONSTRAINT [DF_Cabals_Demons_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO