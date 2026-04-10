-- Realicones (FK)

ALTER TABLE Usuarios
ADD CONSTRAINT fk_Usuarios_Roles
FOREIGN KEY (id_rol)
REFERENCES CatalogoRoles(id_rol);

ALTER TABLE Productos
ADD CONSTRAINT fk_Productos_Monedas
FOREIGN KEY (id_moneda)
REFERENCES CatalogoMonedas(id_moneda);

ALTER TABLE Tasas
ADD CONSTRAINT fk_Tasas_Productos
FOREIGN KEY (id_producto)
REFERENCES Productos(id_producto);

ALTER TABLE Tasas
ADD CONSTRAINT fk_Tasas_Plazos
FOREIGN KEY (id_plazo)
REFERENCES CatalogoPlazos(id_plazo);

ALTER TABLE Cotizaciones
ADD CONSTRAINT fk_Cotizaciones_Tasas
FOREIGN KEY (id_tasa)
REFERENCES Tasas(id_tasa);

ALTER TABLE Cotizaciones
ADD CONSTRAINT fk_Cotizaciones_Impuestos
FOREIGN KEY (id_impuesto)
REFERENCES CatalogoImpuestos(id_impuesto);

ALTER TABLE Cotizaciones
ADD CONSTRAINT fk_Cotizaciones_Usuarios
FOREIGN KEY (id_usuario)
REFERENCES Usuarios(id_usuario);

