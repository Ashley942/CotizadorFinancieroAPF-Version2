CREATE PROCEDURE sp_estado_cotizacion
    @id_cotizacion INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        IF NOT EXISTS (
            SELECT 1
            FROM Cotizaciones
            WHERE id_cotizacion = @id_cotizacion
        )
        BEGIN
            RETURN 0
        END

        UPDATE Cotizaciones
        SET estado =
            CASE
                WHEN estado = 1 THEN 0
                ELSE 1
            END
        WHERE id_cotizacion = @id_cotizacion

        RETURN 1

    END TRY
    BEGIN CATCH

        RETURN 0

    END CATCH

END