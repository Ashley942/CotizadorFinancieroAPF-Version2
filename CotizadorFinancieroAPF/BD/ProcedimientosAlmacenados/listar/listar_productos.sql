CREATE PROCEDURE sp_listar_productos
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        p.id_producto,
        p.nombre_producto,
        p.id_moneda,
		p.estado,
        m.moneda
    FROM Productos p
    INNER JOIN CatalogoMonedas m
        ON p.id_moneda = m.id_moneda
    WHERE p.estado = 1
    ORDER BY p.nombre_producto

END