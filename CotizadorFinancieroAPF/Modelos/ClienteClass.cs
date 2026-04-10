using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CotizadorFinancieroAPF.Modelos
{
    public class ClienteClass
    {
        public int IdCliente { get; set; }
        public string Identificacion { get; set; }
        public string Nombre { get; set; }
        public string Telefono { get; set; }
        public string Correo { get; set; }
        public bool Estado { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime? FechaModificacion { get; set; }
    }
}