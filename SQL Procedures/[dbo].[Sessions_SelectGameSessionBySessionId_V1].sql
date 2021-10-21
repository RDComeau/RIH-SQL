SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sessions_SelectGameSessionBySessionId_V1]
			@SessionId int

AS

BEGIN TRY
	BEGIN TRANSACTION
		SELECT
			s.[Id] as 'Session Id',
			s.[Name] as 'Session Name',
			s.[Access],
			s.[DefaultRules] as 'Session Default Rules',
			s.[CreatorId],
			s.[AcceptorId],
			s.[DateCreated] as 'Session Created',
			s.[DateModified] as 'Session Modified'

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