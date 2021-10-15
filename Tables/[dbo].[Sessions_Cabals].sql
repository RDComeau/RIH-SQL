CREATE TABLE [dbo].[Sessions_Cabals](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SessionId] [int] NOT NULL,
	[CabalId] [int] NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Sessions_Cabals]  WITH CHECK ADD FOREIGN KEY([CabalId])
REFERENCES [dbo].[Cabals] ([Id])
GO

ALTER TABLE [dbo].[Sessions_Cabals]  WITH CHECK ADD FOREIGN KEY([SessionId])
REFERENCES [dbo].[Sessions] ([Id])
GO