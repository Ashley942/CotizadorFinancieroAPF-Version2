-- Procedimientos para listar los catalogos de la base de datos
/*

catalogos:

- monedas
- plazos
- impuestos
- roles

*/

CREATE PROCEDURE sp_listar_ctg_monedas
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        id_moneda,
        moneda
    FROM CatalogoMonedas
    WHERE estado = 1
END
GO


CREATE PROCEDURE sp_listar_ctg_impuestos
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        id_impuesto,
        impuesto
    FROM CatalogoImpuestos
    WHERE estado = 1
END
GO



CREATE PROCEDURE sp_listar_ctg_plazos
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        id_plazo,
        plazo,
        unidad
    FROM CatalogoPlazos
    WHERE estado = 1
END
GO



CREATE PROCEDURE sp_listar_ctg_roles
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        id_rol,
        rol
    FROM CatalogoRoles
    WHERE estado = 1
END
