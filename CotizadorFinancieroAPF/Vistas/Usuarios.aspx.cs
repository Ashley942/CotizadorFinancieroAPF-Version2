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
	
	public partial class Usuarios : System.Web.UI.Page
	{


        UsuarioController controller = new UsuarioController();

        protected void Page_Load(object sender, EventArgs e)
		{
            if (Session["Rol"]?.ToString().ToLower() != "admin")
            {
                Response.Redirect("~/Vistas/NoAutorizado.aspx");
            }

            if (!IsPostBack)
            {
                CargarUsuarios();
            }
        }

        private void CargarUsuarios()
        {
            gvUsuarios.DataSource = controller.ListarUsuarios();
            gvUsuarios.DataBind();
        }

        protected void gvUsuarios_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvUsuarios.EditIndex = e.NewEditIndex;
            CargarUsuarios();

            GridViewRow row = gvUsuarios.Rows[e.NewEditIndex];
            DropDownList ddl = (DropDownList)row.FindControl("ddlRoles");

            ddl.DataSource = controller.ListarRoles();
            ddl.DataTextField = "rol";
            ddl.DataValueField = "id_rol";
            ddl.DataBind();

            string rolActual = ((Label)row.Cells[2].Controls[0]).Text;
            ddl.SelectedIndex = ddl.Items.IndexOf(ddl.Items.FindByText(rolActual));
        }

        protected void gvUsuarios_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvUsuarios.EditIndex = -1;
            CargarUsuarios();
        }

        protected void gvUsuarios_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = gvUsuarios.Rows[e.RowIndex];

            int id = Convert.ToInt32(gvUsuarios.DataKeys[e.RowIndex].Value);

            string nombre = ((TextBox)row.Cells[1].Controls[0]).Text;

            DropDownList ddlRoles = (DropDownList)row.FindControl("ddlRoles");
            int idRol = Convert.ToInt32(ddlRoles.SelectedValue);

            TextBox txtPass = (TextBox)row.FindControl("txtPassword");

            UsuarioClass usuario = new UsuarioClass
            {
                IdUsuario = id,
                Nombre = nombre,
                IdRol = idRol,
                Contrasena = txtPass.Text
            };

            int resultado = controller.ActualizarUsuario(usuario);

            if (resultado == 1)
            {
                lblMensaje.Text = "Usuario actualizado correctamente";
            }
            else if (resultado == 2)
            {
                lblMensaje.Text = "Nombre de usuario ya existe";
            }
            else
            {
                lblMensaje.Text = "Error al actualizar";
            }

            gvUsuarios.EditIndex = -1;
            CargarUsuarios();
        }
        
    }
}