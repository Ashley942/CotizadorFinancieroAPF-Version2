CREATE PROCEDURE sp_insertar_tasa
    @id_producto INT,
    @id_plazo INT,
    @tasa DECIMAL(10,4)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        -- Validar duplicado
        IF EXISTS (
            SELECT 1
            FROM Tasas
            WHERE id_producto = @id_producto
            AND id_plazo = @id_plazo
        )
        BEGIN
            RETURN 2
        END

        INSERT INTO Tasas
        (
            id_producto,
            id_plazo,
            tasa
         
        )
        VALUES
        (
            @id_producto,
            @id_plazo,
            @tasa
           
        )

        RETURN 1

    END TRY
    BEGIN CATCH

        RETURN 0

    END CATCH

END