
using System;
using System.Web;
using System.Web.UI;

namespace CotizadorFinancieroAPF
{
    public class Global : HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {
            // Registrar ScriptResourceMapping para jQuery (usar CDN y fallback)
            ScriptManager.ScriptResourceMapping.AddDefinition("jquery", new ScriptResourceDefinition
            {
                Path = "~/scripts/jquery-3.6.0.min.js",
                DebugPath = "~/scripts/jquery-3.6.0.js",
                CdnPath = "https://code.jquery.com/jquery-3.6.0.min.js",
                CdnDebugPath = "https://code.jquery.com/jquery-3.6.0.js",
                CdnSupportsSecureConnection = true
            });

            // Habilitar validación unobtrusive para WebForms programáticamente
            // Esto evita problemas con esquemas de Web.config que no reconocen el atributo
            System.Web.UI.ValidationSettings.UnobtrusiveValidationMode = System.Web.UI.UnobtrusiveValidationMode.WebForms;
        }
    }
}