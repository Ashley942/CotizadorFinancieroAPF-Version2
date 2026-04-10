using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CotizadorFinancieroAPF.Controladores;
using CotizadorFinancieroAPF.Modelos;
using CotizadorFinancieroAPF.Utilidades;
using ExmMantFacturas.Controladores;

namespace CotizadorFinancieroAPF.Vistas
{
	public partial class CotizadorForm : System.Web.UI.Page
	{

		private readonly ClienteController clienteController = new ClienteController();
		private readonly ProductoController productoController = new ProductoController();
		private readonly ImpuestoController impuestoController = new ImpuestoController();
		private readonly TasaController tasaController = new TasaController();

		

		// ── Ciclo de vida ────────────────────────────────────────────────────
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				cargarddlProductos();
				cargarddlImpuestos();

			}
		}



		// ── Selección de producto → autocompletar tasa ───────────────────────
		protected void ddlProducto_SelectedIndexChanged(object sender, EventArgs e)
		{

			CargarTxtTasa();
		}

        // ── Calcular ─────────────────────────────────────────────────────────
        protected void btnCalcular_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            try
            {
                string tasaTexto = txtTasa.Text.Replace("%", "").Trim();

                decimal monto = Convert.ToDecimal(txtMonto.Text);
                decimal tasaAnual = Convert.ToDecimal(tasaTexto) / 100;
                decimal porcentajeImpuesto = Convert.ToDecimal(ddlImpuesto.SelectedItem.Text) / 100;

                ResultadoCotizacionClass resultado = CalculadoraUtils.CalcularCotizacion(
                    monto,
                    tasaAnual,
                    6, // TODO: Esto debería venir del plazo seleccionado, pero por simplicidad se deja fijo
                    porcentajeImpuesto,
                    30
                );

                txtInteresBruto.Text = resultado.InteresBrutoTotal.ToString("N2");
                txtTotalImpuesto.Text = resultado.ImpuestoTotal.ToString("N2");
                txtTotalNeto.Text = resultado.InteresNetoTotal.ToString("N2");
            }
            catch (Exception ex)
            {
                MostrarAlerta("Error en formato: " + ex.Message);
            }
        }



        // ── Guardar ──────────────────────────────────────────────────────────
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            try
            {
                if (string.IsNullOrEmpty(hfldCliente.Value) || hfldCliente.Value == "0")
                {
                    MostrarAlerta("Debe BUSCAR un cliente antes de guardar.");
                    return;
                }

                if (string.IsNullOrEmpty(hfldTasa.Value) || hfldTasa.Value == "0")
                {
                    MostrarAlerta("Debe calcular la cotización primero.");
                    return;
                }

                int idCliente = Convert.ToInt32(hfldCliente.Value);
                int idTasa = Convert.ToInt32(hfldTasa.Value);
                int idImpuesto = Convert.ToInt32(ddlImpuesto.SelectedValue);

                decimal monto = decimal.Parse(txtMonto.Text);
                decimal bruto = decimal.Parse(txtInteresBruto.Text);
                decimal impTotal = decimal.Parse(txtTotalImpuesto.Text);
                decimal neto = decimal.Parse(txtTotalNeto.Text);

                int idUsuario = Convert.ToInt32(Session["IdUsuario"] ?? 1);

                CotizacionController controller = new CotizacionController();
                bool resultado = controller.InsertarCotizacion(
                    idCliente, idTasa, idImpuesto, monto, bruto, impTotal, neto, idUsuario
                );

                if (resultado)
                {
                    string script = "alert('¡Cotización guardada exitosamente!'); window.location='CotizadorForm.aspx';";
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", script, true);
                }
            }
            catch (Exception ex)
            {
                MostrarAlerta("Error al guardar: " + ex.Message);
            }
        }



        // ── Cancelar ─────────────────────────────────────────────────────────
        protected void btnCancelar_Click(object sender, EventArgs e)
		{

		}

		// ── Utilidades ───────────────────────────────────────────────────────
		private void cargarddlProductos()
		{
			ddlProducto.DataSource = productoController.ListarProductos();
			ddlProducto.DataTextField = "nombre_producto";   
			ddlProducto.DataValueField = "id_producto";     
			ddlProducto.DataBind();

			ddlProducto.Items.Insert(0, new ListItem("— Seleccione un producto —", ""));
		}

		private void cargarddlImpuestos()
		{
			ddlImpuesto.DataSource = impuestoController.ListarImpuestos();
			ddlImpuesto.DataTextField = "impuesto";   
			ddlImpuesto.DataValueField = "id_impuesto";      
			ddlImpuesto.DataBind();
			ddlImpuesto.Items.Insert(0, new ListItem("— Seleccione un impuesto —", ""));
		}

		private void CargarTxtTasa()
		{
			// Verificamos que tengamos Producto y Plazo
			if (string.IsNullOrEmpty(ddlProducto.SelectedValue) || ModalPlazos.IdPlazoSeleccionado == 0)
			{
				return;
			}

			int idProducto = Convert.ToInt32(ddlProducto.SelectedValue);
			int idPlazo = ModalPlazos.IdPlazoSeleccionado;

			// Buscamos la tasa en la base de datos
			var tasa = tasaController.ObtenerTasa(idProducto, idPlazo);

			if (tasa != null)
			{
				// IMPORTANTE: Aquí es donde se "arrastra" el valor al cuadro de texto
				txtTasa.Text = tasa.TasaValor.ToString("F4");
				hfldTasa.Value = tasa.IdTasa.ToString();
			}
			else
			{
				txtTasa.Text = "0.0000";
				ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('No hay una tasa configurada para este producto y plazo.');", true);
			}
		}


		protected void btnSeleccionarPlazo_Click(object sender, EventArgs e)
		{
			// Llamamos al modal para seleccionar un plazo
			ModalPlazos.Abrir();

		}

		private void MostrarAlerta(string mensaje)
		{
			string script = $"alert('{mensaje.Replace("'", "\\'")}');";
			ClientScript.RegisterStartupScript(GetType(), "alerta", script, true);
		}

		protected void ModalPlazos_PlazoSeleccionado(object sender, EventArgs e)
		{
			// 1. Escribimos el texto del plazo (Ej: "5 M")
			txtPlazo.Text = ModalPlazos.TextoPlazo;

			// 2. Llamamos a la función que busca la tasa en la base de datos
			CargarTxtTasa();

			 
		}


		 
	} 

}

