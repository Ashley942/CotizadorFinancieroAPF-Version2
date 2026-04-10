CREATE PROCEDURE sp_actualizar_producto
    @id_producto INT,
    @id_moneda INT,
    @nombre_producto VARCHAR(225)
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

        IF EXISTS (
            SELECT 1
            FROM Productos
            WHERE nombre_producto = @nombre_producto
            AND id_moneda = @id_moneda
            AND id_producto <> @id_producto
        )
        BEGIN
            RETURN 2
        END

        UPDATE Productos
        SET
            id_moneda = @id_moneda,
            nombre_producto = @nombre_producto,
            fecha_modificacion = GETDATE()
        WHERE id_producto = @id_producto

        RETURN 1

    END TRY
    BEGIN CATCH

        RETURN 0

    END CATCH

END