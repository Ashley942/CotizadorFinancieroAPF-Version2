using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CotizadorFinancieroAPF.Modelos
{
    public class UsuarioClass
    {
        //Tomar en cuenta que el usuario puede hacer cotizaciones a el mismo. 
        public int IdUsuario { get; set; }
        public int IdRol { get; set; }
        public string Nombre { get; set; }
        public string Contrasena { get; set; }
        public bool Estado { get; set; } // Se asigna en el sp
        public string Identificacion { get; set; }
        public string Telefono { get; set; }
        public string Correo { get; set; }
        public string Rol { get; set; }
        public DateTime FechaCreacion { get; set; } // Se asigna en el sp
        public DateTime FechaModificacion { get; set; }
    }
}