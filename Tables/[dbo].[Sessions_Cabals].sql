SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Sessions_Cabals](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SessionId] [int] NOT NULL,
	[CabalId] [int] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Sessions_Cabals] ADD  CONSTRAINT [DF_Sessions_Cabals_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO

ALTER TABLE [dbo].[Sessions_Cabals] ADD  CONSTRAINT [DF_Sessions_Cabals_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO

ALTER TABLE [dbo].[Sessions_Cabals]  WITH CHECK ADD FOREIGN KEY([CabalId])
REFERENCES [dbo].[Cabals] ([Id])
GO

ALTER TABLE [dbo].[Sessions_Cabals]  WITH CHECK ADD FOREIGN KEY([SessionId])
REFERENCES [dbo].[Sessions] ([Id])
GO