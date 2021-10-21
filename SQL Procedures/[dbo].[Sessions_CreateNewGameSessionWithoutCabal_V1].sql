SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sessions_CreateNewGameSessionWithoutCabal_V1]
			@SessionName nvarchar(128),
			@Access bit,
			@DefaultRules bit,
			@CreatorId nvarchar(128),
			@CabalName nvarchar(128)

AS

BEGIN TRY
	BEGIN TRANSACTION
		DECLARE
			@SessionId int,
			@CabalId int

			INSERT INTO dbo.Sessions
			(
				[Name],
				[Access],
				[DefaultRules],
				[CreatorId]
			)
			VALUES
			(
				@SessionName,
				@Access,
				@DefaultRules,
				@CreatorId
			)

			Set @SessionId = Scope_Identity()

			INSERT INTO dbo.Cabals
			(
				[Name],
				[DefaultRules],
				[PlayorId]
			)
			VALUES
			(
				@CabalName,
				@DefaultRules,
				@CreatorId
			)

			SET @CabalId = SCOPE_IDENTITY()


			INSERT INTO dbo.Sessions_Cabals
			(
				[SessionId],
				[CabalId]
			)
			VALUES
			(
				@SessionId,
				@CabalId
			)

		SELECT DISTINCT
			s.[Id] as 'Session Id',
			s.[Name] as 'Session Name',
			s.[Access],
			s.[DefaultRules] as 'Session Default Rules',
			s.[CreatorId],
			s.[AcceptorId],
			s.[DateCreated] as 'Session Created',
			s.[DateModified] as 'Session Modified',
			CreatorCabal = (
				Select
					c1.[Id],
					c1.[Name],
					c1.[DefaultRules],
					c1.[PlayorId],
					c1.[DateCreated],
					c1.[DateModified]

				FROM dbo.Cabals c1
				JOIN dbo.Sessions_Cabals sc on c1.Id = sc.CabalId
				WHERE c1.Id = @CabalId
				FOR JSON AUTO,
				WITHOUT_ARRAY_WRAPPER
			)

		FROM [dbo].[Sessions] s
		WHERE s.Id = @SessionId
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