-- Procedimientos almacenados para insertar datos en los catálogos 
/*

catalogos:

- monedas
- plazos
- impuestos
- roles

*/

CREATE PROCEDURE sp_insertar_ctg_moneda
    @moneda VARCHAR(225)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        IF EXISTS (
            SELECT 1 
            FROM CatalogoMonedas 
            WHERE moneda = @moneda
        )
        BEGIN
            RETURN 2
        END

        INSERT INTO CatalogoMonedas
        (
            moneda
        )
        VALUES
        (
            UPPER(LTRIM(RTRIM(@moneda))) -- Convertir a mayúsculas para evitar duplicados por diferencias de mayúsculas/minúsculas
        
        )

        RETURN 1

    END TRY
    BEGIN CATCH
        RETURN 0
    END CATCH

END
GO

CREATE PROCEDURE sp_insertar_ctg_impuesto
    @impuesto DECIMAL(6,4)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        IF EXISTS (
            SELECT 1
            FROM CatalogoImpuestos
            WHERE impuesto = @impuesto
        )
        BEGIN
            RETURN 2
        END

        INSERT INTO CatalogoImpuestos
        (
            impuesto
          
        )
        VALUES
        (
            @impuesto
      
        )

        RETURN 1

    END TRY
    BEGIN CATCH
        RETURN 0
    END CATCH

END
GO


CREATE PROCEDURE sp_insertar_ctg_plazo
    @plazo VARCHAR(225),
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
        )
        BEGIN
            RETURN 2
        END

        INSERT INTO CatalogoPlazos
        (
            plazo,
            unidad
        )
        VALUES
        (
            @plazo,
            @unidad
         
        )

        RETURN 1

    END TRY
    BEGIN CATCH
        RETURN 0
    END CATCH

END
GO

CREATE PROCEDURE sp_insertar_ctg_rol
    @rol VARCHAR(225)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        IF EXISTS (
            SELECT 1
            FROM CatalogoRoles
            WHERE rol = @rol
        )
        BEGIN
            RETURN 2
        END

        INSERT INTO CatalogoRoles
        (
            rol
        )
        VALUES
        (
            UPPER(LTRIM(RTRIM(@rol))) -- Convertir a mayúsculas y eliminar espacios al inicio y al final
                                         -- para evitar duplicados por diferencias de formato
   
        )

        RETURN 1

    END TRY
    BEGIN CATCH
        RETURN 0
    END CATCH

END