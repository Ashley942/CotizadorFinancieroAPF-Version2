


-- Abir el SQL Server Management Studio y ejecutar este script para crear la base de datos y sus objetos. Usar Modo SQLCMD para que las variables funcionen correctamente.
-- Se debe abrir el mismo archivo master.sql dentro del proyecto para que las rutas relativas funcionen correctamente, o ajustar la variable RutaBase a la ubicación real de la carpeta BD.

:setvar RutaBase "C:\Users\l_die\Documents\Ash\CotizadorFinancieroAPF\CotizadorFinancieroAPF\CotizadorFinancieroAPF\BD" -- Cambia esta ruta por la ubicación real de tu carpeta BD

PRINT '$(RutaBase)\Estructura\creacion_db.sql'

PRINT 'INICIANDO CREACIÓN DE BASE DE DATOS...'
GO

-- =========================
-- CREACIÓN DE BASE DE DATOS
-- =========================
:r $(RutaBase)\Estructura\creacion_db.sql
GO

--  usar la BD recién creada
USE cotizador_fin_apf;
GO

PRINT ' BASE DE DATOS SELECCIONADA'
GO

-- =========================
-- CREACIÓN DE TABLAS
-- =========================
PRINT ' CREANDO TABLAS...'
GO

:r $(RutaBase)\Estructura\creacion_tablas.sql
GO


-- =========================
-- RELACIONES (FK)
-- =========================
PRINT ' CREANDO RELACIONES...'
GO

:r $(RutaBase)\Estructura\creacion_relaciones.sql
GO


-- =========================
-- RESTRICCIONES
-- =========================
PRINT ' CREANDO RESTRICCIONES...'
GO

:r $(RutaBase)\Estructura\creacion_restricciones.sql
GO



-- =========================
-- PROCEDIMIENTOS ALMACENADOS
-- =========================

PRINT ' CREANDO PROCEDIMIENTOS...'
GO

-- INSERTAR
:r $(RutaBase)\ProcedimientosAlmacenados\insertar\insertar_catalogos.sql
GO

:r $(RutaBase)\ProcedimientosAlmacenados\insertar\insertar_cotizacion.sql
GO

:r $(RutaBase)\ProcedimientosAlmacenados\insertar\insertar_producto.sql
GO

:r $(RutaBase)\ProcedimientosAlmacenados\insertar\insertar_tasa.sql
GO

:r $(RutaBase)\ProcedimientosAlmacenados\insertar\insertar_usuario.sql
GO


-- ACTUALIZAR
:r $(RutaBase)\ProcedimientosAlmacenados\actualizar\actualizar_catalogos.sql
GO

:r $(RutaBase)\ProcedimientosAlmacenados\actualizar\actualizar_usuario.sql
GO

:r $(RutaBase)\ProcedimientosAlmacenados\actualizar\actualizar_producto.sql
GO

:r $(RutaBase)\ProcedimientosAlmacenados\actualizar\actualizar_cotizacion.sql
GO

:r $(RutaBase)\ProcedimientosAlmacenados\actualizar\actualizar_tasa.sql


-- LISTAR
:r $(RutaBase)\ProcedimientosAlmacenados\listar\listar_usuarios.sql
GO

:r $(RutaBase)\ProcedimientosAlmacenados\listar\listar_productos.sql
GO

:r $(RutaBase)\ProcedimientosAlmacenados\listar\listar_catalogos.sql
GO

:r $(RutaBase)\ProcedimientosAlmacenados\listar\listar_cotizaciones.sql
GO

:r $(RutaBase)\ProcedimientosAlmacenados\listar\listar_tasas.sql
GO



-- ESTADO
:r $(RutaBase)\ProcedimientosAlmacenados\estado\estado_usuario.sql
GO

:r $(RutaBase)\ProcedimientosAlmacenados\estado\estado_producto.sql
GO

:r $(RutaBase)\ProcedimientosAlmacenados\estado\estado_catalogos.sql
GO

:r $(RutaBase)\ProcedimientosAlmacenados\estado\estado_cotizacion.sql
GO

:r $(RutaBase)\ProcedimientosAlmacenados\estado\estado_tasa.sql
GO




-- =========================
-- FINAL
-- =========================
PRINT ' BASE DE DATOS CREADA CORRECTAMENTE'
GO