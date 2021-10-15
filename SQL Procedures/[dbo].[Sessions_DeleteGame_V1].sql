CREATE PROCEDURE [dbo].[Sessions_DeleteGame_V1]
			@GameId int,
			@CreatorCabalId int,
			@AcceptorCabalId int
AS

BEGIN TRY
	BEGIN TRANSACTION
		DELETE
		FROM dbo.Sessions_Cabals
		WHERE SessionId = @GameId	
			
		DELETE
		FROM dbo.Sessions
		WHERE Id = @GameId

		DELETE
		FROM dbo.Cabals
		WHERE Id = @CreatorCabalId

		DELETE
		FROM dbo.Cabals
		WHERE Id = @AcceptorCabalId
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