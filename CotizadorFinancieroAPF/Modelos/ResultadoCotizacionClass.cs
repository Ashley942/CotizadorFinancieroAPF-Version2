using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using CotizadorFinancieroAPF.Utilidades;

namespace CotizadorFinancieroAPF.Modelos
{
    public class ResultadoCotizacionClass
    {
        public int IdCotizacion { get; set; }
        public string Usuario { get; set; }
        public string Producto { get; set; }
        public decimal Monto { get; set; }
        public int Plazo { get; set; }
        public decimal Tasa { get; set; }
        public decimal InteresBruto { get; set; }
        public decimal Impuesto { get; set; }
        public decimal Neto { get; set; }
        public DateTime Fecha { get; set; }

        public decimal InteresBrutoTotal { get; set; }
        public decimal ImpuestoTotal { get; set; }
        public decimal InteresNetoTotal { get; set; }

        public ResultadoCotizacionClass(decimal interesBrutoTotal, decimal impuestoTotal, decimal interesNetoTotal)
        {
            
            InteresBrutoTotal = Math.Round(interesBrutoTotal);
            ImpuestoTotal = Math.Round(impuestoTotal);
            InteresNetoTotal = Math.Round(interesNetoTotal);
        }

    }


}