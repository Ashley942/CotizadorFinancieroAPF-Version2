CREATE PROCEDURE sp_estado_productos
    @id_producto INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        IF NOT EXISTS (
            SELECT 1
            FROM Productos
            WHERE id_producto = @id_producto
        )
        BEGIN
            RETURN 0
        END

        UPDATE Productos
        SET estado =
            CASE
                WHEN estado = 1 THEN 0
                ELSE 1
            END
        WHERE id_producto = @id_producto

        RETURN 1

    END TRY
    BEGIN CATCH

        RETURN 0

    END CATCH

END