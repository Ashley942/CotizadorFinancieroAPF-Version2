GO
CREATE PROCEDURE sp_actualizar_tasa
    @id_tasa INT,
    @id_producto INT,
    @id_plazo INT,
    @tasa DECIMAL(10,4)
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

        -- Validar duplicado
        IF EXISTS (
            SELECT 1
            FROM Tasas
            WHERE id_producto = @id_producto
            AND id_plazo = @id_plazo
            AND id_tasa <> @id_tasa
        )
        BEGIN
            RETURN 2
        END

        UPDATE Tasas
        SET
            id_producto = @id_producto,
            id_plazo = @id_plazo,
            tasa = @tasa,
            fecha_modificacion = GETDATE()
        WHERE id_tasa = @id_tasa

        RETURN 1

    END TRY
    BEGIN CATCH

        RETURN 0

    END CATCH

END
GO