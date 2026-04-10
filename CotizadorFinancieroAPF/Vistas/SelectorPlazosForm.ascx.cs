using System;

using System.Web.UI;
using System.Web.UI.WebControls;
using CotizadorFinancieroAPF.Controladores;

namespace CotizadorFinancieroAPF.Vistas
{
	public partial class SelectorPlazosForm : System.Web.UI.UserControl, IPostBackEventHandler
	{

		public event EventHandler PlazoSeleccionado;
		
		private readonly PlazoController plazoController = new PlazoController();

		protected void Page_Load(object sender, EventArgs e)
		{
			// Importante: Solo cargar la primera vez para no perder selecciones
			if (!IsPostBack)
			{
				CargarPlazos();
			}
		}

		public void Abrir()
		{
			
		ScriptManager.RegisterStartupScript(
				this, GetType(), "abrirModal",
				"document.getElementById('modalPlazo').style.display='flex';",
				true);
		}

		
		public int IdPlazoSeleccionado
		{
			get
			{
				if (!string.IsNullOrEmpty(hfPlazoSeleccionado.Value))
				{
					ViewState["IdPlazo"] = Convert.ToInt32(hfPlazoSeleccionado.Value);
				}
				return (int)(ViewState["IdPlazo"] ?? 0);
			}
		}


		public string TextoPlazo
		{
			get
			{
				if (!string.IsNullOrEmpty(hfTextoPlazo.Value))
				{
					ViewState["TextoPlazo"] = hfTextoPlazo.Value;
				}
				return (ViewState["TextoPlazo"] ?? "Sin selección").ToString();
			}
		}

		public void RaisePostBackEvent(string eventArgument)
		{
			if (eventArgument == "PlazoSeleccionado")
			{
				PlazoSeleccionado?.Invoke(this, EventArgs.Empty);
			}
		}

		private void CargarPlazos()
		{

			rptPlazos.DataSource = plazoController.ListarPlazos();
			rptPlazos.DataBind();

		
			}

	
			
			}

}