using CotizadorFinancieroAPF.Modelos;
using ExmMantFacturas.Controladores;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CotizadorFinancieroAPF.Vistas
{
    public partial class Productos : System.Web.UI.Page
    {
        ProductoController controller = new ProductoController();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Usuario"] == null)
                Response.Redirect("~/Vistas/LoginForm.aspx");

            if (Session["Rol"]?.ToString().ToLower() != "admin")
                Response.Redirect("~/Vistas/NoAutorizado.aspx");

            if (!IsPostBack)
            { 
                CargarProductos();
                CargarMonedas();
            }
        }

        protected void btnNuevo_Click(object sender, EventArgs e)
        {
            hfIdProducto.Value = "";
            txtNombre.Text = "";

            ScriptManager.RegisterStartupScript(this, GetType(), "modal", "mostrarModal();", true);
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            ProductoClass producto = new ProductoClass
            {
                IdProducto = string.IsNullOrEmpty(hfIdProducto.Value) ? 0 : Convert.ToInt32(hfIdProducto.Value),
                Nombre = txtNombre.Text,
                IdMoneda = Convert.ToInt32(ddlMoneda.SelectedValue) 
            };

            int resultado = producto.IdProducto == 0
                ? controller.InsertarProducto(producto)
                : controller.ActualizarProducto(producto);

            lblMensaje.Text = resultado == 1 ? "Guardado correctamente" : "Error";

            CargarProductos();
        }

        protected void gvProductos_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Editar")
            {
                var dt = controller.ListarProductos();

                foreach (DataRow row in dt.Rows)
                {
                    if (Convert.ToInt32(row["id_producto"]) == id)
                    {
                        hfIdProducto.Value = id.ToString();
                        txtNombre.Text = row["nombre_producto"].ToString();
                        CargarMonedas();
                        ddlMoneda.SelectedValue = row["id_moneda"].ToString();

                        ScriptManager.RegisterStartupScript(this, GetType(), "modal", "mostrarModal();", true);
                        break;
                    }
                }
            }

            if (e.CommandName == "Estado")
            {
                controller.CambiarEstadoProducto(id);
                CargarProductos();
            }
        }

        private void CargarProductos()
        {
            gvProductos.DataSource = controller.ListarProductos();
            gvProductos.DataBind();
        }

        private void CargarMonedas()
        {
            ddlMoneda.DataSource = controller.ListarMonedas(); // debes tener este método
            ddlMoneda.DataTextField = "moneda";
            ddlMoneda.DataValueField = "id_moneda";
            ddlMoneda.DataBind();
        }

    }
}