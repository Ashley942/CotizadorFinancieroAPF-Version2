using CotizadorFinancieroAPF.Controladores;
using CotizadorFinancieroAPF.Modelos;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CotizadorFinancieroAPF.Vistas
{
    public partial class Plazos : System.Web.UI.Page
    {
        PlazoController controller = new PlazoController();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                CargarPlazos();
        }

        private void CargarPlazos()
        {
            gvPlazos.DataSource = controller.ListarPlazos();
            gvPlazos.DataBind();
        }

        protected void btnNuevo_Click(object sender, EventArgs e)
        {
            hfIdPlazo.Value = "";
            txtPlazo.Text = "";

            ScriptManager.RegisterStartupScript(this, GetType(), "modal", "mostrarModal();", true);
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            CatalogoPlazoClass plazo = new CatalogoPlazoClass
            {
                IdPlazo = string.IsNullOrEmpty(hfIdPlazo.Value) ? 0 : Convert.ToInt32(hfIdPlazo.Value),
                Plazo = Convert.ToInt32(txtPlazo.Text),
                UnidadPlazo = ddlUnidad.SelectedValue[0]
            };

            int resultado;

            if (plazo.IdPlazo == 0)
                resultado = controller.InsertarPlazo(plazo);
            else
                resultado = controller.ActualizarPlazo(plazo);

            switch (resultado)
            {
                case 1:
                    lblMensaje.CssClass = "text-success";
                    lblMensaje.Text = "Guardado correctamente";
                    break;

                case 2:
                    lblMensaje.CssClass = "text-warning";
                    lblMensaje.Text = "Ya existe un plazo con ese valor";
                    break;

                default:
                    lblMensaje.CssClass = "text-danger";
                    lblMensaje.Text = "Error al guardar";
                    break;
            }

            CargarPlazos();
        }

        protected void gvPlazos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
         
            if (e.CommandName == "Editar")
            {
                int index = Convert.ToInt32(e.CommandArgument);

                GridViewRow row = gvPlazos.Rows[index];

                hfIdPlazo.Value = gvPlazos.DataKeys[index].Values["IdPlazo"].ToString();
                txtPlazo.Text = gvPlazos.DataKeys[index].Values["Plazo"].ToString();

                string unidad = gvPlazos.DataKeys[index].Values["UnidadPlazo"].ToString();
                ddlUnidad.SelectedValue = unidad;

                ScriptManager.RegisterStartupScript(this, GetType(), "modal", "mostrarModal();", true);
            }

            if (e.CommandName == "Estado")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                controller.CambiarEstado(id);
                CargarPlazos();
            }
        }

    }
}