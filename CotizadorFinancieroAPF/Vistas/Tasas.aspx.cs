using CotizadorFinancieroAPF.Controladores;
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
    public partial class Tasas : System.Web.UI.Page
    {
        TasaController controller = new TasaController();
        ProductoController productoController = new ProductoController();
        PlazoController plazoController = new PlazoController();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Usuario"] == null)
                Response.Redirect("~/Vistas/LoginForm.aspx");

            if (Session["Rol"]?.ToString().ToLower() != "admin")
                Response.Redirect("~/Vistas/NoAutorizado.aspx");

            if (!IsPostBack)
            {
                CargarTasas();
                CargarProductos();
                CargarPlazos();
            }
        }

        private void CargarTasas()
        {
            gvTasas.DataSource = controller.ListarTasas();
            gvTasas.DataBind();
        }

        private void CargarProductos()
        {
            ddlProducto.DataSource = productoController.ListarProductos();
            ddlProducto.DataTextField = "nombre_producto";
            ddlProducto.DataValueField = "id_producto";
            ddlProducto.DataBind();
        }

        private void CargarPlazos()
        {
            ddlPlazo.DataSource = plazoController.ListarPlazos();
            ddlPlazo.DataTextField = "plazo";
            ddlPlazo.DataValueField = "IdPlazo";
            ddlPlazo.DataBind();
        }

        protected void btnNuevo_Click(object sender, EventArgs e)
        {
            hfIdTasa.Value = "";
            txtTasa.Text = "";

            ScriptManager.RegisterStartupScript(this, GetType(), "modal", "mostrarModal();", true);
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            TasaClass tasa = new TasaClass
            {
                IdTasa = string.IsNullOrEmpty(hfIdTasa.Value) ? 0 : Convert.ToInt32(hfIdTasa.Value),
                IdProducto = Convert.ToInt32(ddlProducto.SelectedValue),
                IdPlazo = Convert.ToInt32(ddlPlazo.SelectedValue),
                TasaValor = Convert.ToDecimal(txtTasa.Text)
            };

            int resultado = tasa.IdTasa == 0
                ? controller.InsertarTasa(tasa)
                : controller.ActualizarTasa(tasa);

            lblMensaje.Text = resultado == 1 ? "Guardado correctamente" :
                              resultado == 2 ? "Ya existe esa combinación" :
                              "Error";

            CargarTasas();
        }

        protected void gvTasas_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Editar")
            {
                DataTable dt = controller.ListarTasas();

                foreach (DataRow row in dt.Rows)
                {
                    if (Convert.ToInt32(row["id_tasa"]) == id)
                    {
                        hfIdTasa.Value = id.ToString();
                        ddlProducto.SelectedValue = row["id_producto"].ToString();
                        ddlPlazo.SelectedValue = row["id_plazo"].ToString();
                        txtTasa.Text = row["tasa"].ToString();

                        ScriptManager.RegisterStartupScript(this, GetType(), "modal", "mostrarModal();", true);
                        break;
                    }
                }
            }
            if (e.CommandName == "Estado")
            {
                controller.CambiarEstadoTasa(id);
                CargarTasas();
            }
        }
    }
}