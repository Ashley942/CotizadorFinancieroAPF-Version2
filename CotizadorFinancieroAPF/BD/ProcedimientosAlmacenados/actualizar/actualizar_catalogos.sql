-- Procedimientos para actualizar los catalogos de la base de datos
/*

catalogos:

- monedas
- plazos
- impuestos
- roles

*/

CREATE PROCEDURE sp_actualizar_ctg_moneda
    @id_moneda INT,
    @moneda VARCHAR(225)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        IF EXISTS (
            SELECT 1
            FROM CatalogoMonedas
            WHERE moneda = @moneda
            AND id_moneda <> @id_moneda
        )
        BEGIN
            RETURN 2
        END

        UPDATE CatalogoMonedas
        SET moneda = @moneda,
            fecha_modificacion = GETDATE()
        WHERE id_moneda = @id_moneda

        RETURN 1

    END TRY
    BEGIN CATCH
        RETURN 0
    END CATCH

END
GO

CREATE PROCEDURE sp_actualizar_ctg_impuesto
    @id_impuesto INT,
    @impuesto DECIMAL(5,4)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        IF EXISTS (
            SELECT 1
            FROM CatalogoImpuestos
            WHERE impuesto = @impuesto
            AND id_impuesto <> @id_impuesto
        )
        BEGIN
            RETURN 2
        END

        UPDATE CatalogoImpuestos
        SET impuesto = @impuesto,
            fecha_modificacion = GETDATE()
        WHERE id_impuesto = @id_impuesto

        RETURN 1

    END TRY
    BEGIN CATCH
        RETURN 0
    END CATCH

END
GO


CREATE PROCEDURE sp_actualizar_ctg_plazo
    @id_plazo INT,
    @plazo INT,
    @unidad CHAR(1) -- Vease D = días, M = meses, A = años
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        IF EXISTS (
            SELECT 1
            FROM CatalogoPlazos
            WHERE plazo = @plazo
            AND unidad = @unidad
            AND id_plazo <> @id_plazo
        )
        BEGIN
            RETURN 2
        END

        UPDATE CatalogoPlazos
        SET 
            plazo = @plazo,
            unidad = @unidad,
            fecha_modificacion = GETDATE()
        WHERE id_plazo = @id_plazo

        IF @@ROWCOUNT = 0
            RETURN 0

        RETURN 1

    END TRY
    BEGIN CATCH
        RETURN 0
    END CATCH
END
GO


CREATE PROCEDURE sp_actualizar_ctg_rol
    @id_rol INT,
    @rol VARCHAR(225)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        IF EXISTS (
            SELECT 1
            FROM CatalogoRoles
            WHERE rol = @rol
            AND id_rol <> @id_rol
        )
        BEGIN
            RETURN 2
        END

        UPDATE CatalogoRoles
        SET rol = @rol,
            fecha_modificacion = GETDATE()
        WHERE id_rol = @id_rol

        RETURN 1

    END TRY
    BEGIN CATCH
        RETURN 0
    END CATCH

END

