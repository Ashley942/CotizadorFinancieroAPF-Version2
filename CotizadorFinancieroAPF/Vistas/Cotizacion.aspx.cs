using CotizadorFinancieroAPF.Controladores;
using ExmMantFacturas.Controladores;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CotizadorFinancieroAPF.Vistas
{
    public partial class Cotizacion : System.Web.UI.Page
    {

        ClienteController clienteController = new ClienteController();
        ProductoController productoController = new ProductoController();
        ImpuestoController impuestoController = new ImpuestoController();
        TasaController tasaController = new TasaController();
        PlazoController plazoController = new PlazoController();
        CotizacionController cotizacionController = new CotizacionController();

        decimal totalBrutoGrid = 0;
        decimal totalImpuestoGrid = 0;
        decimal totalNetoGrid = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Usuario"] == null)
                Response.Redirect("~/Vistas/LoginForm.aspx");

            if (!IsPostBack)
            {
                CargarClienteSesion();
                CargarProductos();
                CargarPlazosInicial();
                CargarImpuestos();
            }
            else
            {
                if (ViewState["productos"] != null)
                {
                    DataTable dt = (DataTable)ViewState["productos"];
                    AsignarSimbolos(dt);
                }
            }

        }

        private void CargarPlazosInicial()
        {
            ddlPlazo.DataSource = plazoController.ListarPlazos();
            ddlPlazo.DataTextField = "Descripcion";
            ddlPlazo.DataValueField = "IdPlazo";
            ddlPlazo.DataBind();
        }

        private void CargarClienteSesion()
        {
            hfIdCliente.Value = Session["IdUsuario"].ToString();
            txtCliente.Text = Session["Usuario"].ToString();
            txtCorreo.Text = Session["Correo"].ToString();
        }

        private void CargarProductos()
        {
            DataTable dt = productoController.ListarProductos();

            ddlProducto.DataSource = dt;
            ddlProducto.DataTextField = "nombre_producto";
            ddlProducto.DataValueField = "id_producto";
            ddlProducto.DataBind();


            // Guardar en ViewState
            ViewState["productos"] = dt;

            // Asignar símbolos
            AsignarSimbolos(dt);

        }

        private void AsignarSimbolos(DataTable dt)
        {
            for (int i = 0; i < ddlProducto.Items.Count; i++)
            {
                string moneda = dt.Rows[i]["moneda"].ToString();
                string simbolo = ObtenerSimbolo(moneda);

                ddlProducto.Items[i].Attributes["data-simbolo"] = simbolo;

                Session["SimboloMoneda"] = simbolo;
            }
        }

        private void ActualizarTasa()
        {

            if (ddlProducto.Items.Count == 0 || ddlPlazo.Items.Count == 0)
                return;

            int idProducto = Convert.ToInt32(ddlProducto.SelectedValue);
            int idPlazo = Convert.ToInt32(ddlPlazo.SelectedValue);

            var tasa = tasaController.ObtenerTasa(idProducto, idPlazo);

            if (tasa != null)
            {
                txtTasa.Text = tasa.TasaValor.ToString("0.00");
                hfIdTasa.Value = tasa.IdTasa.ToString();
            }
            else
            {
                txtTasa.Text = "0.00";
                hfIdTasa.Value = "";
            }
        }


        protected void ddlPlazo_SelectedIndexChanged(object sender, EventArgs e)
        {
            ActualizarTasa();
        }

        protected void ddlProducto_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlProducto.Items.Count == 0)
                return;

            int idProducto = Convert.ToInt32(ddlProducto.SelectedValue);

            // se usan para recargar los plazos constantemente
            ddlPlazo.DataSource = plazoController.ListarPlazos();
            ddlPlazo.DataTextField = "Descripcion";
            ddlPlazo.DataValueField = "IdPlazo";
            ddlPlazo.DataBind();



            // Se Selecciona el primer plazo automáticamente
            if (ddlPlazo.Items.Count > 0)
                ddlPlazo.SelectedIndex = 0;


            ActualizarTasa();
        }

        private string ObtenerSimbolo(string moneda)
        {
            if (moneda == "Colon")
                return "₡";
            else
                return "$";
        }

        protected void btnCalcular_Click(object sender, EventArgs e)
        {
            decimal monto = Convert.ToDecimal(txtMonto.Text);
            int plazo = Convert.ToInt32(ddlPlazo.SelectedValue);
            int idProducto = Convert.ToInt32(ddlProducto.SelectedValue);
            int idCliente = Convert.ToInt32(hfIdCliente.Value);
            int idImpuesto = Convert.ToInt32(ddlImpuesto.SelectedValue);

            decimal tasa = Convert.ToDecimal(txtTasa.Text) / 100;

            // 🔥 impuesto desde BD
            decimal impuestoPorcentaje = ObtenerPorcentajeImpuesto(idImpuesto);

            DataTable dt = new DataTable();
            dt.Columns.Add("Mes", typeof(int));
            dt.Columns.Add("Monto", typeof(decimal));
            dt.Columns.Add("InteresBruto", typeof(decimal));
            dt.Columns.Add("Impuesto", typeof(decimal));
            dt.Columns.Add("InteresNeto", typeof(decimal));

            decimal totalBruto = 0;
            decimal totalImpuesto = 0;
            decimal totalNeto = 0;

            decimal interesMensual = (monto * tasa / 360) * 30;

            for (int i = 1; i < plazo; i++)
            {
                decimal impuestoMes = interesMensual * impuestoPorcentaje;
                decimal netoMes = interesMensual - impuestoMes;

                dt.Rows.Add(i, monto, interesMensual, impuestoMes, netoMes);

                totalBruto += interesMensual;
                totalImpuesto += impuestoMes;
                totalNeto += netoMes;
            }

            // Mostrar
            gvDetalle.DataSource = dt;
            gvDetalle.DataBind();


            if (!int.TryParse(hfIdTasa.Value, out int idTasa))
            {
                throw new Exception("No se pudo obtener la tasa seleccionada");
            }

            int idCotizacion = cotizacionController.GuardarCotizacion(idCliente,idTasa,idImpuesto,monto,totalBruto,totalImpuesto, totalNeto);


            lblNumeroCotizacion.Text = $"Cotización N°: {idCotizacion:D9}";

            // 🔒 Bloquear
            BloquearCampos();

            lblClienteResumen.Text = txtCliente.Text;
            lblCorreoResumen.Text = txtCorreo.Text;

            string simbolo = ddlProducto.SelectedItem.Attributes["data-simbolo"] ?? "₡";

            Session["SimboloMoneda"] = simbolo;

            lblProductoResumen.Text = ddlProducto.SelectedItem.Text;
            lblMontoResumen.Text = simbolo + " " + monto.ToString("N2");
            lblPlazoResumen.Text = ddlPlazo.SelectedItem.Text;
            lblTasaResumen.Text = txtTasa.Text + " %";

            lblImpuestoResumen.Text = ddlImpuesto.SelectedItem.Text;

            pnlResultado.Visible = true;
        }

        private decimal ObtenerPorcentajeImpuesto(int idImpuesto)
        {
            DataTable dt = impuestoController.ListarImpuestos();

            DataRow[] rows = dt.Select("id_impuesto = " + idImpuesto);

            if (rows.Length > 0)
                return Convert.ToDecimal(rows[0]["impuesto"]);

            throw new Exception("Impuesto no encontrado");
        }

        private void BloquearCampos()
        {
            ddlProducto.Enabled = false;
            ddlPlazo.Enabled = false;
            ddlImpuesto.Enabled = false;
            txtMonto.Enabled = false;
            btnCalcular.Enabled = false;
        }

        protected void btnNueva_Click(object sender, EventArgs e)
        {
            // Limpiar
            txtMonto.Text = "";
            txtTasa.Text = "";

            ddlProducto.SelectedIndex = 0;
            ddlPlazo.SelectedIndex = 0;
            ddlImpuesto.SelectedIndex = 0;

            // Desbloquear
            ddlProducto.Enabled = true;
            ddlPlazo.Enabled = true;
            ddlImpuesto.Enabled = true;
            txtMonto.Enabled = true;
            btnCalcular.Enabled = true;

            // Ocultar resultados
            pnlResultado.Visible = false;

            // Limpiar labels
            lblNumeroCotizacion.Text = "";
        }

        protected void gvDetalle_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                totalBrutoGrid += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "InteresBruto"));
                totalImpuestoGrid += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Impuesto"));
                totalNetoGrid += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "InteresNeto"));
            }

            
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                string simbolo = lblSimbolo.InnerText;

                e.Row.Cells[0].Text = "TOTAL";
                e.Row.Cells[0].Font.Bold = true;

                e.Row.Cells[2].Text = simbolo + " " + totalBrutoGrid.ToString("N2");
                e.Row.Cells[3].Text = simbolo + " " + totalImpuestoGrid.ToString("N2");
                e.Row.Cells[4].Text = simbolo + " " + totalNetoGrid.ToString("N2");

            }
        }

        private void CargarImpuestos()
        {
            DataTable dt = impuestoController.ListarImpuestos();

            dt.Columns.Add("impuesto_mostrar", typeof(string));

            foreach (DataRow row in dt.Rows)
            {
                decimal valor = Convert.ToDecimal(row["impuesto"]);
                row["impuesto_mostrar"] = (valor * 100).ToString("N0"); 
            }

            ddlImpuesto.DataSource = dt;
            ddlImpuesto.DataTextField = "impuesto_mostrar";   
            ddlImpuesto.DataValueField = "id_impuesto";  
            ddlImpuesto.DataBind();

            ddlImpuesto.SelectedIndex = 0;
        }

    }
}