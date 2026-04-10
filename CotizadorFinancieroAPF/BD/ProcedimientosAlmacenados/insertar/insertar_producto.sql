CREATE PROCEDURE sp_insertar_producto
    @id_moneda INT,
    @nombre_producto VARCHAR(225)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        IF EXISTS (
            SELECT 1
            FROM Productos
            WHERE nombre_producto = @nombre_producto
            AND id_moneda = @id_moneda
        )
        BEGIN
            RETURN 2
        END

        INSERT INTO Productos
        (
            id_moneda,
            nombre_producto
          
        )
        VALUES
        (
            @id_moneda,
             UPPER(LTRIM(RTRIM(@nombre_producto))) -- Convertir a mayúsculas para evitar duplicados por diferencias de mayúsculas/minúsculas
      
        )

        RETURN 1

    END TRY
    BEGIN CATCH

        RETURN 0

    END CATCH

END