CREATE PROCEDURE sp_listar_usuarios
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        u.id_usuario,
        u.nombre_usuario,
        u.id_rol,
        r.rol
    FROM Usuarios u
    INNER JOIN CatalogoRoles r
        ON u.id_rol = r.id_rol
    WHERE u.estado = 1
    ORDER BY u.nombre_usuario

END
GO


CREATE PROCEDURE sp_listar_usuario_por_correo
    @correo VARCHAR(225)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        -- Validar que el usuario exista
        IF NOT EXISTS (
            SELECT 1
            FROM Usuarios
            WHERE correo = @correo
        )
        BEGIN
            RETURN 2 -- Usuario no encontrado
        END

        SELECT
            u.id_usuario,
            u.id_rol,
            u.nombre_usuario,
            u.identificacion,
            u.correo,
            u.contrasenia,
			u.telefono,
            r.rol AS nombre_rol 
        FROM Usuarios u
         INNER JOIN CatalogoRoles r
            ON u.id_rol = r.id_rol
         WHERE u.correo = @correo

        RETURN 1 -- Éxito

    END TRY
    BEGIN CATCH

        RETURN 0 -- Error inesperado

    END CATCH

END