using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CotizadorFinancieroAPF.Controladores;


namespace CotizadorFinancieroAPF.Vistas
{
    public partial class Perfil : System.Web.UI.Page
    {
        UsuarioController controller = new UsuarioController();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Usuario"] == null)
            {
                Response.Redirect("~/Vistas/LoginForm.aspx");
            }

            if (!IsPostBack)
            {
                CargarPerfil();
            }

        }
        private void CargarPerfil()
        {
            string correo = Session["Correo"]?.ToString();

            var usuario = controller.ObtenerUsuarioPorCorreo(correo);

            if (usuario != null)
            {
                lblNombre.Text = usuario.Nombre;
                lblCorreo.Text = usuario.Correo;
                lblIdentificacion.Text = usuario.Identificacion;
                lblTelefono.Text = usuario.Telefono;
                lblRol.Text = usuario.Rol;
            }
        }
    }
}