CREATE PROCEDURE sp_insertar_usuario
    @id_rol         INT,
    @identificacion VARCHAR(225),
    @nombre_usuario VARCHAR(225),
    @contrasenia    VARCHAR(225),
    @telefono       VARCHAR(225),
    @correo         VARCHAR(225)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        -- Validaciones de negocio
        IF NOT EXISTS (SELECT 1 FROM CatalogoRoles WHERE id_rol = @id_rol)
            RETURN 3 -- Rol no encontrado

        IF EXISTS (SELECT 1 FROM Usuarios WHERE nombre_usuario = @nombre_usuario)
            RETURN 2 -- Usuario duplicado

        IF EXISTS (SELECT 1 FROM Usuarios WHERE correo = @correo)
            RETURN 4 -- Correo duplicado

        IF EXISTS (SELECT 1 FROM Usuarios WHERE identificacion = @identificacion)
            RETURN 5 -- Identificación duplicada

        -- Inserción
        INSERT INTO Usuarios (id_rol, identificacion, nombre_usuario, contrasenia, telefono, correo)
        VALUES (
            @id_rol,
            @identificacion,
            UPPER(LTRIM(RTRIM(@nombre_usuario))),
            HASHBYTES('SHA2_256', @contrasenia),
            @telefono,
            LOWER(LTRIM(RTRIM(@correo)))
        )

        RETURN 1 -- Éxito

    END TRY
    BEGIN CATCH
        -- Error inesperado del sistema 
        THROW;
    END CATCH
END