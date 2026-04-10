using CotizadorFinancieroAPF.Controladores;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CotizadorFinancieroAPF.Vistas
{
    public partial class HistorialCotizaciones : System.Web.UI.Page
    {
        CotizacionController controller = new CotizacionController();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                CargarCotizaciones();
        }

        private void CargarCotizaciones(string usuario = "")
        {
            gvCotizaciones.DataSource = controller.ListarCotizaciones(usuario);
            gvCotizaciones.DataBind();
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            CargarCotizaciones(txtFiltroUsuario.Text);
        }
    }
}