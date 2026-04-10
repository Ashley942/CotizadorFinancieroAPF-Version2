INSERT INTO CatalogoRoles (rol)
VALUES
('USUARIO'),
('ADMIN')


--usuario administrador

USE [cotizador_fin_apf]
GO

INSERT INTO [dbo].[Usuarios]
(
    [id_rol],
    [identificacion],
    [nombre_usuario],
    [contrasenia],
    [telefono],
    [correo],
    [estado],
    [fecha_creacion],
    [fecha_modificacion]
)
VALUES
(
    2,
    '123456789',
    'ADMIN',
    HASHBYTES('SHA2_256', '12345'),
    '22222222',
    'admin@gmail.com',
    1,
    GETDATE(),
    NULL
)
GO

