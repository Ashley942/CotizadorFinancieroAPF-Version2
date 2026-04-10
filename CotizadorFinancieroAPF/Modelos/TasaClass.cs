using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CotizadorFinancieroAPF.Modelos
{
    public class TasaClass
    {
        public int IdTasa { get; set; }
        public int IdProducto { get; set; }
        public int IdPlazo { get; set; }
        public decimal TasaValor { get; set; }
        public char Unidad { get; set; }
        public bool Estado { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime? FechaModificacion { get; set; }
    }
}