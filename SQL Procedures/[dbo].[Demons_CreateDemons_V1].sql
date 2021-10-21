SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Demons_CreateDemons_V1]
			@Cost int,
			@Move int,
			@Life int,
			@Combat int,
			@Fly bit,
			@DemonName nvarchar(128),
			@ClassName nvarchar(128),
			@DefaultRules bit,
			@DemonId int output

AS

	BEGIN TRY
		BEGIN TRANSACTION
			INSERT INTO [dbo].[Demons]
					   ([Cost]
					   ,[Move]
					   ,[Life]
					   ,[Combat]
					   ,[Fly]
					   ,[DemonName]
					   ,[ClassName]
					   ,[DefaultRules])
				 VALUES
					   (@Cost
					   ,@Move
					   ,@Life
					   ,@Combat
					   ,@Fly
					   ,@DemonName
					   ,@ClassName
					   ,@DefaultRules)

			Set @DemonId = Scope_Identity()

				Select [Id]
					  ,[Cost]
					  ,[Move]
					  ,[Life]
					  ,[Combat]
					  ,[Fly]
					  ,[DemonName]
					  ,[ClassName]
					  ,[DefaultRules]
					  ,[DateCreated]
					  ,[DateModified]
				FROM [dbo].[Demons]
				WHERE [Id] = @DemonId

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