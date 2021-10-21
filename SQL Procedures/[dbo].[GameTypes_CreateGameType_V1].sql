SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[GameTypes_CreateGameType_V1]
		@GameTypeName nvarchar(128),
		@GameTypeNumber int,
		@GameTypeId int OUTPUT

	AS
		BEGIN TRY
			BEGIN TRANSACTION
				INSERT INTO [dbo].[GameTypes]
				   ([GameTypeName]
				   ,[GameTypeNumber])
				VALUES
				   (@GameTypeName
				   ,@GameTypeNumber)

				Set @GameTypeId = Scope_Identity()

				--SELECT [Id]
				--	,[GameTypeName]
				--	,[GameTypeNumber]
				--	,[DateCreated]
				--	,[DateModified]
				--FROM [dbo].[GameTypes]
				--WHERE [Id] = @GameTypeId
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			IF @@TRANCOUNT > 0
				ROLLBACK TRANSACTION

			DECLARE @ErrorMessage NVARCHAR(4000);
			DECLARE @ErrorSeverity INT;
			DECLARE @ErrorState INT;

			SELECT
			   @ErrorMessage = ERROR_MESSAGE(),
			   @ErrorSeverity = ERROR_SEVERITY(),
			   @ErrorState = ERROR_STATE();

			RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
		END CATCH
GO