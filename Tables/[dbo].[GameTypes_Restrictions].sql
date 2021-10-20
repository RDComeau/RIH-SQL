SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[GameTypes_Restrictions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GameTypeId] [int] NOT NULL,
	[RestrictionId] [int] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_GameTypes_Restrictions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[GameTypes_Restrictions] ADD  CONSTRAINT [DF_GameTypes_Restrictions_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO

ALTER TABLE [dbo].[GameTypes_Restrictions] ADD  CONSTRAINT [DF_GameTypes_Restrictions_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO