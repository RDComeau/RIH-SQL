CREATE TABLE [dbo].[Demons](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[DefaultRules] [bit] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Demons] ADD  CONSTRAINT [DF_Demons_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO

ALTER TABLE [dbo].[Demons] ADD  CONSTRAINT [DF_Demons_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO