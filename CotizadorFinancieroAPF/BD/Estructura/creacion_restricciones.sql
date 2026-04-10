-- Unique

-- Restricción que garantizará que no haya duplicados en esa combinación específica.
ALTER TABLE Tasas
ADD CONSTRAINT uq_producto_plazo UNIQUE (id_producto, id_plazo);

-- Restriccion que evita dublicados en combinaciones
ALTER TABLE CatalogoPlazos
ADD CONSTRAINT uq_plazo_unidad UNIQUE (plazo, unidad);

