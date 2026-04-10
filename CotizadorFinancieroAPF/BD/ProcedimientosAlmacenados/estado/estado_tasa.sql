CREATE PROCEDURE sp_estado_tasa
    @id_tasa INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        IF NOT EXISTS (
            SELECT 1
            FROM Tasas
            WHERE id_tasa = @id_tasa
        )
        BEGIN
            RETURN 0
        END

        UPDATE Tasas
        SET estado =
            CASE
                WHEN estado = 1 THEN 0
                ELSE 1
            END
        WHERE id_tasa = @id_tasa

        RETURN 1

    END TRY
    BEGIN CATCH

        RETURN 0

    END CATCH

END