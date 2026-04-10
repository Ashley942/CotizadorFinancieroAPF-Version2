using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using CotizadorFinancieroAPF.Modelos;

namespace CotizadorFinancieroAPF.Utilidades
{
    public static class CalculadoraUtils
    {

        /*
            Esta clase contiene métodos para calcular el interés bruto, el impuesto y el interés neto,
            así como un método para realizar la cotización completa.

            Ejemplo de uso:

                var test = CalculadoraUtils.CalcularCotizacion(
                50000000.00m,
                0.0410m,
                6, -- cantidad de periodos (meses)
                0.13m,
                30 -- días por periodo (mes)
            );


        */

        private const int DIAS_ANIO = 360;
        private const int DIAS_MES = 30;

        public static decimal CalcularInteresBruto(decimal monto, decimal tasaAnual, int dias)
        {
            return monto * tasaAnual / DIAS_ANIO * dias;
        }

        public static decimal CalcularImpuesto(decimal interesBruto, decimal porcentajeImpuesto)
        {
            return interesBruto * porcentajeImpuesto;
        }

        public static decimal CalcularInteresNeto(decimal interesBruto, decimal impuesto)
        {
            return interesBruto - impuesto;
        }

        public static ResultadoCotizacionClass CalcularCotizacion(
            decimal monto,
            decimal tasaAnual,
            int cantidadPeriodos,
            decimal porcentajeImpuesto,
            int diasPorPeriodo)
        {
            decimal interesBrutoTotal = 0;
            decimal impuestoTotal = 0;
            decimal interesNetoTotal = 0;

            for (int i = 0; i < cantidadPeriodos; i++)
            {
                decimal interesBruto = CalcularInteresBruto(monto, tasaAnual, diasPorPeriodo);
                decimal impuesto = CalcularImpuesto(interesBruto, porcentajeImpuesto);
                decimal interesNeto = CalcularInteresNeto(interesBruto, impuesto);

                interesBrutoTotal += interesBruto;
                impuestoTotal += impuesto;
                interesNetoTotal += interesNeto;
            }

            return new ResultadoCotizacionClass(interesBrutoTotal, impuestoTotal, interesNetoTotal);
        }

    }
}