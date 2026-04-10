CREATE PROCEDURE sp_estado_usuario
    @id_usuario INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        IF NOT EXISTS (
            SELECT 1
            FROM Usuarios
            WHERE id_usuario = @id_usuario
        )
        BEGIN
            RETURN 0
        END

        UPDATE Usuarios
        SET estado =
            CASE
                WHEN estado = 1 THEN 0
                ELSE 1
            END
        WHERE id_usuario = @id_usuario

        RETURN 1

    END TRY
    BEGIN CATCH

        RETURN 0

    END CATCH

END