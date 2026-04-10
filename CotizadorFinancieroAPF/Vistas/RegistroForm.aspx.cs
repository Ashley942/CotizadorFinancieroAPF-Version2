using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CotizadorFinancieroAPF.Controladores;
using CotizadorFinancieroAPF.Modelos;

namespace CotizadorFinancieroAPF.Vistas
{
    public partial class RegistroForm : System.Web.UI.Page
    {

        UsuarioController usuarioController = new UsuarioController();


        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            try
            {
                UsuarioClass nuevo = new UsuarioClass
                {
                    Identificacion = txtIdentificacion.Text.Trim(),
                    Nombre = txtNuevoUsuario.Text.Trim(),
                    Contrasena = txtRegPass.Text.Trim(),
                    Telefono = txtTefelono.Text.Trim(),
                    Correo = txtCorreo.Text.Trim()
                    
                };

                int resultado = usuarioController.RegistrarUsuario(nuevo);
                
                if (resultado == 1)
                {
               
                    lblMensaje.ForeColor = System.Drawing.Color.Green;
                    lblMensaje.Text = "Usuario registrado correctamente.";
                }
                else
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = "El correo ya existe o hubo un error en BD.";
                }
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Error al registrar: " + ex.Message;
            }
        }
    }
}