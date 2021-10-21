SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[GameTypes_Restrictions_CreateGameTypeAndRestrictionsAndReference_V1]
			@GameTypeName nvarchar(128),
			@GameTypeNumber int,
			@ExcludedDemons nvarchar(128),
			@MaxDemons int,
			@Souls int

AS

	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE
			@GameTypeId int,
			@RestrictionId int

			EXEC [dbo].[GameTypes_CreateGameType_V1]
					@GameTypeName,
					@GameTypeNumber,
					@GameTypeId OUTPUT

			EXEC [dbo].[Restrictions_CreateNewRestriction_V1]
					@ExcludedDemons,
					@MaxDemons,
					@Souls,
					@RestrictionId OUTPUT

			EXEC [dbo].[GameTypes_Restrictions_CreateGameTypeAndRestrictionsReference_V1]
					@GameTypeId,
					@RestrictionId

			SELECT 
				gt.Id AS GameTypeId,
				gt.GameTypeName,
				gt.GameTypeNumber,
				gt.DateCreated AS GameTypeDateCreated,
				gt.DateModified AS GameTypeDateModified,
				r.Id AS RestrictionsId,
				r.DemonClassNumbers,
				r.MaxDemons,
				r.Souls,
				r.DateCreated AS RestrictionsDateCreated,
				r.DateModified AS RestrictionsDateModified

			FROM [dbo].[GameTypes_Restrictions] AS gr
			JOIN [dbo].[GameTypes] AS gt ON gr.GameTypeId = gt.Id
			JOIN [dbo].[Restrictions] AS r on gr.RestrictionId = r.Id
			WHERE gt.Id = GameTypeId AND r.Id = RestrictionId

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