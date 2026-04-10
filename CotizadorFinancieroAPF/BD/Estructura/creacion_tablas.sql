CREATE TABLE CatalogoRoles (
    id_rol INT IDENTITY(1,1) PRIMARY KEY,
    rol VARCHAR(225) NOT NULL UNIQUE,
    estado BIT NOT NULL DEFAULT 1,
    fecha_creacion DATETIME NOT NULL DEFAULT GETDATE(),
    fecha_modificacion DATETIME
);

CREATE TABLE CatalogoMonedas (
    id_moneda INT IDENTITY(1,1) PRIMARY KEY,
    moneda VARCHAR(225) NOT NULL UNIQUE,
    estado BIT NOT NULL DEFAULT 1,
    fecha_creacion DATETIME NOT NULL DEFAULT GETDATE(),
    fecha_modificacion DATETIME
);

CREATE TABLE CatalogoImpuestos (
    id_impuesto INT IDENTITY(1,1) PRIMARY KEY,
    impuesto DECIMAL(6,4) NOT NULL UNIQUE,
    estado BIT NOT NULL DEFAULT 1,
    fecha_creacion DATETIME NOT NULL DEFAULT GETDATE(),
    fecha_modificacion DATETIME
);

CREATE TABLE CatalogoPlazos (
    id_plazo INT IDENTITY(1,1) PRIMARY KEY,
    plazo INT NOT NULL,
    unidad CHAR(1) NOT NULL CHECK (unidad IN ('D', 'M', 'A')),
    estado BIT NOT NULL DEFAULT 1,
    fecha_creacion DATETIME NOT NULL DEFAULT GETDATE(),
    fecha_modificacion DATETIME
);

CREATE TABLE Usuarios (
    id_usuario INT IDENTITY(1,1) PRIMARY KEY,

    id_rol INT NOT NULL,

    identificacion VARCHAR(50) NOT NULL,
    nombre_usuario VARCHAR(100) NOT NULL,
    contrasenia VARBINARY(256) NOT NULL,
    telefono VARCHAR(50) NOT NULL UNIQUE,
    correo VARCHAR(150) NOT NULL UNIQUE,

    estado BIT NOT NULL DEFAULT 1,
    fecha_creacion DATETIME NOT NULL DEFAULT GETDATE(),
    fecha_modificacion DATETIME NULL
);

CREATE TABLE Productos (
    id_producto INT IDENTITY(1,1) PRIMARY KEY,
    id_moneda INT NOT NULL,
    nombre_producto VARCHAR(225) UNIQUE NOT NULL,
    estado BIT NOT NULL DEFAULT 1,
    fecha_creacion DATETIME NOT NULL DEFAULT GETDATE(),
    fecha_modificacion DATETIME
);

CREATE TABLE Tasas (
    id_tasa INT IDENTITY(1,1) PRIMARY KEY,
    id_producto INT NOT NULL,
    id_plazo INT NOT NULL,
    tasa DECIMAL(5,4) NOT NULL,
    estado BIT NOT NULL DEFAULT 1,
    fecha_creacion DATETIME NOT NULL DEFAULT GETDATE(),
    fecha_modificacion DATETIME
);

CREATE TABLE Cotizaciones (
    id_cotizacion INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_tasa INT NOT NULL,
    id_impuesto INT NOT NULL,
    monto DECIMAL(18,2) NOT NULL,
    interes_bruto_total DECIMAL(18,2) NOT NULL,
    impuesto_total DECIMAL(18,2) NOT NULL,
    neto_total DECIMAL(18,2) NOT NULL,
    estado BIT NOT NULL DEFAULT 1,
    fecha_creacion DATETIME NOT NULL DEFAULT GETDATE(),
    fecha_modificacion DATETIME
);