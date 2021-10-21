SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Cabals_CreateNewCabal_V1]
		@CabalName nvarchar(128),
		@PlayorId nvarchar(128),
		@DefaultRules bit
AS
BEGIN TRY
	BEGIN TRANSACTION
		DECLARE
			@CabalId int

		INSERT INTO [dbo].[Cabals]
				   ([Name]
				   ,[DefaultRules]
				   ,[PlayorId])
			 VALUES
				   (@CabalName
				   ,@DefaultRules
				   ,@PlayorId)

		Set @CabalId = Scope_Identity()

			Select [Id]
				  ,[Name]
				  ,[DefaultRules]
				  ,[PlayorId]
				  ,[DateCreated]
				  ,[DateModified]
			FROM [dbo].[Cabals]
			WHERE [Id] = @CabalId
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