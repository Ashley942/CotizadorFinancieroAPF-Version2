CREATE PROCEDURE sp_insertar_cotizacion
    @id_usuario INT,
    @id_tasa INT,
    @id_impuesto INT,
    @monto DECIMAL(18,2),
    @interes_bruto_total DECIMAL(18,2),
    @impuesto_total DECIMAL(18,2),
    @neto_total DECIMAL(18,2)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

   INSERT INTO Cotizaciones
        (
            id_usuario,
            id_tasa,
            id_impuesto,
            monto,
            interes_bruto_total,
            impuesto_total,
            neto_total,
            estado,
            fecha_creacion,
            fecha_modificacion
        )
        VALUES
        (
            @id_usuario,
            @id_tasa,
            @id_impuesto,
            @monto,
            @interes_bruto_total,
            @impuesto_total,
            @neto_total,
            1,                
            GETDATE(),
            GETDATE()
        );

        SELECT SCOPE_IDENTITY();

    END TRY
    BEGIN CATCH
        SELECT -1;
    END CATCH
END
