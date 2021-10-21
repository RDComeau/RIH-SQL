SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[GameTypes_Restrictions_CreateGameTypeAndRestrictionsReference_V1]
			@GameTypeId int,
			@RestrictionId int
AS

	BEGIN TRY
		BEGIN TRANSACTION
			INSERT INTO [dbo].[GameTypes_Restrictions]
			   ([GameTypeId]
			   ,[RestrictionId])
			VALUES
			   (@GameTypeId
			   ,@RestrictionId)

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