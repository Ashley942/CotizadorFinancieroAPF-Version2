using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CotizadorFinancieroAPF.Vistas
{
    public partial class Menu : UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Rol"] != null)
            {
                string rol = Session["Rol"].ToString().Trim().ToLower();

                // Solo admin ve usuarios
                menuUsuarios.Visible = (rol == "admin");
                menuProductos.Visible = (rol == "admin");
                menuHistorial.Visible = (rol == "admin");
                menuImpuestos.Visible = (rol == "admin");
                menuPlazos.Visible = (rol == "admin");
                menuTasas.Visible = (rol == "admin");
            }
            else
            {
                menuUsuarios.Visible = false;
                menuUsuarios.Visible = false;
                menuProductos.Visible = false;
                menuHistorial.Visible = false;
                menuImpuestos.Visible = false;
                menuPlazos.Visible = false;
                menuTasas.Visible = false;

            }

            btnCotizacion.Visible = true;
        }

        protected void btnInicio_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Vistas/PaginaInicial.aspx");
        }

        protected void btnUsuarios_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Vistas/Usuarios.aspx");
        }

        protected void btnTasas_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Vistas/Tasas.aspx");
        }

        protected void btnImpuestos_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Vistas/Impuestos.aspx");
        }

        protected void btnHistorial_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Vistas/HistorialCotizaciones.aspx");
        }

        protected void btnPlazos_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Vistas/Plazos.aspx");
        }

        protected void btnPerfil_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Vistas/Perfil.aspx");
        }

        protected void btnProductos_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Vistas/Productos.aspx");
        }

        protected void btnCotizacion_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Vistas/Cotizacion.aspx");
        }
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Vistas/LoginForm.aspx");
        }
    }
    
}