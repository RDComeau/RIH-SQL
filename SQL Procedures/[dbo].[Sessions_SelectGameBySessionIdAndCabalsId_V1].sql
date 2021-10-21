SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sessions_SelectGameBySessionIdAndCabalsId_V1]
			@SessionId int,
			@CreatorCabalId int,
			@AcceptorCabalId int

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
				WHERE c1.Id = @CreatorCabalId
				FOR JSON AUTO,
				WITHOUT_ARRAY_WRAPPER
			),
			AcceptorCabal  = (
				Select
					c2.[Id],
					c2.[Name],
					c2.[DefaultRules],
					c2.[PlayorId],
					c2.[DateCreated],
					c2.[DateModified]

				FROM dbo.Cabals c2
				JOIN dbo.Sessions_Cabals sc on c2.Id = sc.CabalId
				WHERE c2.Id = @AcceptorCabalId
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