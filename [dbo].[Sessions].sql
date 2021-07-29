CREATE TABLE [dbo].[Sessions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Access] [bit] NOT NULL,
	[DefaultRules] [bit] NOT NULL,
	[CreatorId] [nvarchar](128) NOT NULL,
	[AcceptorId] [nvarchar](128) NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Sessions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Sessions] ADD  CONSTRAINT [DF_Sessions_AcceptorId]  DEFAULT ('') FOR [AcceptorId]
GO

ALTER TABLE [dbo].[Sessions] ADD  CONSTRAINT [DF_Sessions_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO

ALTER TABLE [dbo].[Sessions] ADD  CONSTRAINT [DF_Sessions_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO