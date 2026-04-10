CREATE PROCEDURE sp_listar_tasas
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        t.id_tasa,
        p.id_producto,
        p.nombre_producto,
        pl.id_plazo,
        pl.plazo,
		pl.unidad,
        t.tasa,
		t.estado
    FROM Tasas t
    INNER JOIN Productos p
        ON t.id_producto = p.id_producto
    INNER JOIN CatalogoPlazos pl
        ON t.id_plazo = pl.id_plazo
    WHERE t.estado = 1
    ORDER BY p.nombre_producto, pl.plazo

END
GO

-- Obtener una tasa especifica por producto y plazo

CREATE PROCEDURE sp_obtener_tasa
    @id_producto INT,
    @id_plazo INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT tasa, id_tasa
    FROM Tasas
    WHERE 
        estado = 1
        AND id_producto = @id_producto
        AND id_plazo = @id_plazo
END