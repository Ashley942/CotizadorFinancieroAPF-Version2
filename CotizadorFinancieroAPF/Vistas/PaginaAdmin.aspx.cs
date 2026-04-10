using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CotizadorFinancieroAPF.Vistas
{
    public partial class PaginaAdmin : System.Web.UI.Page
    {
       protected void Page_Load(object sender, EventArgs e)
        {
            // 🔐 Validar sesión
            if (Session["Usuario"] == null)
            {
                Response.Redirect("~/Vistas/LoginForm.aspx");
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Vistas/LoginForm.aspx");
        }
    }
}