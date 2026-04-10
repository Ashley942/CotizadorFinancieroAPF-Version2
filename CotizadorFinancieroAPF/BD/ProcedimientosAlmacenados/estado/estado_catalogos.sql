-- Procedimientos para cambiar el estado de las tablas de catalogos

/*

catalogos:

- monedas
- plazos
- impuestos
- roles

*/

CREATE PROCEDURE sp_estado_ctg_moneda
    @id_moneda INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        IF NOT EXISTS (
            SELECT 1 
            FROM CatalogoMonedas 
            WHERE id_moneda = @id_moneda
        )
        BEGIN
            RETURN 0
        END

        UPDATE CatalogoMonedas
        SET estado = CASE 
                        WHEN estado = 1 THEN 0
                        ELSE 1
                     END
        WHERE id_moneda = @id_moneda

        RETURN 1

    END TRY
    BEGIN CATCH
        RETURN 0
    END CATCH

END
GO

CREATE PROCEDURE sp_estado_ctg_impuesto
    @id_impuesto INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        IF NOT EXISTS (
            SELECT 1 
            FROM CatalogoImpuestos
            WHERE id_impuesto = @id_impuesto
        )
        BEGIN
            RETURN 0
        END

        UPDATE CatalogoImpuestos
        SET estado = CASE 
                        WHEN estado = 1 THEN 0
                        ELSE 1
                     END
        WHERE id_impuesto = @id_impuesto

        RETURN 1

    END TRY
    BEGIN CATCH
        RETURN 0
    END CATCH

END
GO

CREATE PROCEDURE sp_estado_ctg_plazo
    @id_plazo INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        IF NOT EXISTS (
            SELECT 1 
            FROM CatalogoPlazos
            WHERE id_plazo = @id_plazo
        )
        BEGIN
            RETURN 0
        END

        UPDATE CatalogoPlazos
        SET estado = CASE 
                        WHEN estado = 1 THEN 0
                        ELSE 1
                     END,
        fecha_modificacion = GETDATE()

        WHERE id_plazo = @id_plazo

        IF @@ROWCOUNT = 0
            RETURN 0 -- no actualizó

        RETURN 1 -- éxito

    END TRY
    BEGIN CATCH
        RETURN 0
    END CATCH

END
GO


CREATE PROCEDURE sp_estado_ctg_rol
    @id_rol INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        IF NOT EXISTS (
            SELECT 1 
            FROM CatalogoRoles
            WHERE id_rol = @id_rol
        )
        BEGIN
            RETURN 0
        END

        UPDATE CatalogoRoles
        SET estado = CASE 
                        WHEN estado = 1 THEN 0
                        ELSE 1
                     END
        WHERE id_rol = @id_rol

        RETURN 1

    END TRY
    BEGIN CATCH
        RETURN 0
    END CATCH

END