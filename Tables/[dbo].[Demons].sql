SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Demons](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Cost] [int] NOT NULL,
	[Move] [int] NOT NULL,
	[Life] [int] NOT NULL,
	[Combat] [int] NOT NULL,
	[Fly] [bit] NOT NULL,
	[DemonName] [nvarchar](128) NOT NULL,
	[ClassName] [nvarchar](128) NOT NULL,
	[DefaultRules] [bit] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Demons] ADD  CONSTRAINT [DF_Demons_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO

ALTER TABLE [dbo].[Demons] ADD  CONSTRAINT [DF_Demons_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO