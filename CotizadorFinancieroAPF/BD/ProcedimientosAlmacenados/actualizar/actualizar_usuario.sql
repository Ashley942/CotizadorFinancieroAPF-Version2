CREATE PROCEDURE sp_actualizar_usuario
    @id_usuario INT,
    @id_rol INT,
    @nombre_usuario VARCHAR(225),
    @contrasenia VARCHAR(225)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        IF NOT EXISTS (
            SELECT 1
            FROM Usuarios
            WHERE id_usuario = @id_usuario
        )
        BEGIN
            RETURN 0
        END

        -- Validar duplicado
        IF EXISTS (
            SELECT 1
            FROM Usuarios
            WHERE nombre_usuario = @nombre_usuario
            AND id_usuario <> @id_usuario
        )
        BEGIN
            RETURN 2
        END

        UPDATE Usuarios
        SET
            id_rol = @id_rol,
            nombre_usuario = @nombre_usuario,
            contrasenia = CASE 
                WHEN @contrasenia IS NOT NULL AND @contrasenia <> ''
                THEN HASHBYTES('SHA2_256', @contrasenia)
                ELSE contrasenia
            END,
            fecha_modificacion = GETDATE()
        WHERE id_usuario = @id_usuario

        RETURN 1

    END TRY
    BEGIN CATCH

        RETURN 0

    END CATCH

END