CREATE PROCEDURE sp_actualizar_cotizacion
    @id_cotizacion INT,
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

        IF NOT EXISTS (
            SELECT 1
            FROM Cotizaciones
            WHERE id_cotizacion = @id_cotizacion
        )
        BEGIN
            RETURN 0
        END

        UPDATE Cotizaciones
        SET
            id_usuario = @id_usuario,
            id_tasa = @id_tasa,
            id_impuesto = @id_impuesto,
            monto = @monto,
            interes_bruto_total = @interes_bruto_total,
            impuesto_total = @impuesto_total,
            neto_total = @neto_total,
            fecha_modificacion = GETDATE()
        WHERE id_cotizacion = @id_cotizacion

        RETURN 1

    END TRY
    BEGIN CATCH

        RETURN 0

    END CATCH

END