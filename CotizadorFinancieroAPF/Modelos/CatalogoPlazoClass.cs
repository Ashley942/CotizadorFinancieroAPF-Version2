using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CotizadorFinancieroAPF.Modelos
{
    public class CatalogoPlazoClass
    {
        public int IdPlazo { get; set; }

        public int Plazo { get; set; }

        public char UnidadPlazo { get; set; }

        public bool Estado { get; set; }

        public DateTime FechaCreacion { get; set; }

        public DateTime? FechaModificacion { get; set; }

        public string Descripcion
        {
            get
            {
                if (UnidadPlazo == 'M')
                    return Plazo + (Plazo == 1 ? " mes" : " meses");
                else if (UnidadPlazo == 'D')
                    return Plazo + (Plazo == 1 ? " día" : " días");
                else
                    return Plazo.ToString();
            }
        }

    }

}
