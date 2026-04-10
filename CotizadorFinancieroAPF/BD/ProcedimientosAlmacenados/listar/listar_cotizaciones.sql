/*

Muestra todas las cotizaciones activas en la base de datos.


*/

CREATE PROCEDURE sp_listar_cotizaciones
 @usuario VARCHAR(100) = NULL

AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        c.id_cotizacion,
        u.nombre_usuario,
        p.nombre_producto,
        pl.plazo,
        t.tasa,
        c.monto,
        c.interes_bruto_total,
        c.impuesto_total,
        c.neto_total,
        c.fecha_creacion
    FROM Cotizaciones c
    INNER JOIN Usuarios u 
        ON c.id_usuario = u.id_usuario

    INNER JOIN Tasas t 
        ON c.id_tasa = t.id_tasa

    INNER JOIN Productos p 
        ON t.id_producto = p.id_producto

    INNER JOIN CatalogoPlazos pl 
        ON t.id_plazo = pl.id_plazo

    WHERE 
        (@usuario IS NULL 
        OR u.nombre_usuario LIKE '%' + @usuario + '%')

    ORDER BY c.fecha_creacion DESC

END
GO

-- Listar por id_cotizacion

CREATE PROCEDURE sp_listar_cotizacion_id
    @id_cotizacion INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        c.id_cotizacion,
        cl.nombre_cliente,
        p.nombre_producto,
        pl.plazo,
        c.monto,
        c.interes_bruto_total,
        c.impuesto_total,
        c.neto_total,
        u.nombre_usuario,
        c.fecha_creacion
    FROM Cotizaciones c
    INNER JOIN Clientes cl       ON c.id_cliente = cl.id_cliente
    INNER JOIN Tasas t           ON c.id_tasa    = t.id_tasa
    INNER JOIN Productos p       ON t.id_producto = p.id_producto
    INNER JOIN CatalogoPlazos pl ON t.id_plazo   = pl.id_plazo
    INNER JOIN Usuarios u        ON c.id_usuario = u.id_usuario
    WHERE c.id_cotizacion = @id_cotizacion
      AND c.estado = 1;
END
GO

