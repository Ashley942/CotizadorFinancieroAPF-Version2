using CotizadorFinancieroAPF.Controladores;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CotizadorFinancieroAPF.Modelos;

namespace CotizadorFinancieroAPF.Vistas
{
    public partial class Impuestos : System.Web.UI.Page
    {
        ImpuestoController controller = new ImpuestoController();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Usuario"] == null)
                Response.Redirect("~/Vistas/LoginForm.aspx");

            if (Session["Rol"]?.ToString().ToLower() != "admin")
                Response.Redirect("~/Vistas/NoAutorizado.aspx");

            if (!IsPostBack)
                CargarImpuestos();
        }

        private void CargarImpuestos()
        {
            gvImpuestos.DataSource = controller.ListarImpuestos();
            gvImpuestos.DataBind();
        }

        // 🔹 NUEVO
        protected void btnNuevo_Click(object sender, EventArgs e)
        {
            hfIdImpuesto.Value = "";
            txtImpuesto.Text = "";

            ScriptManager.RegisterStartupScript(this, GetType(), "modal", "mostrarModalImpuesto();", true);
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {

            decimal valorIngresado = Convert.ToDecimal(txtImpuesto.Text);

            decimal valorReal = valorIngresado / 100;

            CatalogoImpuestoClass impuesto = new CatalogoImpuestoClass
            {
                IdImpuesto = string.IsNullOrEmpty(hfIdImpuesto.Value) ? 0 : Convert.ToInt32(hfIdImpuesto.Value),
                Impuesto = valorReal
            };

            int resultado = impuesto.IdImpuesto == 0 ? controller.InsertarImpuesto(impuesto) : controller.ActualizarImpuesto(impuesto);

            lblMensaje.Text = resultado == 1 ? "Guardado correctamente" : "Error";

            CargarImpuestos();
        }

        protected void gvImpuestos_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Editar")
            {
                DataTable dt = controller.ListarImpuestos();

                foreach (DataRow row in dt.Rows)
                {
                    if (Convert.ToInt32(row["id_impuesto"]) == id)
                    {
                        hfIdImpuesto.Value = id.ToString();
                        txtImpuesto.Text = row["Impuesto"].ToString();

                        ScriptManager.RegisterStartupScript(this, GetType(), "modal", "mostrarModalImpuesto();", true);
                        break;
                    }
                }
            }

            if (e.CommandName == "Estado")
            {
                controller.CambiarEstadoImpuesto(id);
                CargarImpuestos();
            }
        }
    }
}