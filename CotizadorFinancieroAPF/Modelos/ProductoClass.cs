using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CotizadorFinancieroAPF.Modelos
{
    public class ProductoClass
    {
        public int IdProducto { get; set; }
        public int IdMoneda { get; set; }
        public string Nombre { get; set; }
        public bool Estado { get; set; }
        public string Moneda { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime? FechaModificacion { get; set; }
    }
}