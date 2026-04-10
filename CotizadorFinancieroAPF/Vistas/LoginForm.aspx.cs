using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CotizadorFinancieroAPF.Controladores;
using CotizadorFinancieroAPF.Modelos;

namespace CotizadorFinancieroAPF.Vistas
{
	
	public partial class LoginForm : System.Web.UI.Page
	{


        UsuarioController usuarioController = new UsuarioController();

        protected void Page_Load(object sender, EventArgs e)
		{
		}

        protected void btnRegistrarse_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Vistas/RegistroForm.aspx");
        }

        protected void btnLogin_Click(object sender, EventArgs e)
		{
			string correo = txtCorreo.Text;
			string password = txtContrasenia.Text;


			UsuarioClass usuarioLogeado = usuarioController.ValidarLogin(correo, password); ;

            if (usuarioLogeado != null)
			{
                // Guardar sesión
                Session["Usuario"] = usuarioLogeado.Nombre;
                Session["IdUsuario"] = usuarioLogeado.IdUsuario;
                Session["Rol"] = usuarioLogeado.Rol;
				Session["Correo"] = usuarioLogeado.Correo;

                
                Response.Redirect("~/Vistas/PaginaInicial.aspx");
                
			}
			else
			{
				lblMensaje.Text = "Usuario o contraseña incorrectos.";
			}


		}
    }
}