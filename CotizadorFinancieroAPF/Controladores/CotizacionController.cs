using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace CotizadorFinancieroAPF.Controladores
{
	public class CotizacionController
	{
		// Recuperamos la cadena de conexión del Web.config
		private readonly string connectionString = ConfigurationManager.ConnectionStrings["Conexion"].ConnectionString;

        public int GuardarCotizacion(int idUsuario, int idTasa, int idImpuesto, decimal monto, decimal totalBruto, decimal totalImpuesto, decimal totalNeto)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand("sp_insertar_cotizacion", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@id_usuario", idUsuario);
                cmd.Parameters.AddWithValue("@id_tasa", idTasa);
                cmd.Parameters.AddWithValue("@id_impuesto", idImpuesto);
                cmd.Parameters.AddWithValue("@monto", monto);
                cmd.Parameters.AddWithValue("@interes_bruto_total", totalBruto);
                cmd.Parameters.AddWithValue("@impuesto_total", totalImpuesto);
                cmd.Parameters.AddWithValue("@neto_total", totalNeto);

                conn.Open();
                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }

        public DataTable ListarCotizaciones(string usuario = "")
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand("sp_listar_cotizaciones", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Usuario", usuario);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                return dt;
            }
        }

        /// <summary>
        /// Inserta una nueva cotización en la base de datos.
        /// </summary>
        public bool InsertarCotizacion(int idCli, int idTas, int idImp, decimal mon, decimal bruto, decimal impTotal, decimal neto, int idUsu)
		{
			try
			{
				using (SqlConnection conn = new SqlConnection(connectionString))
				{
					SqlCommand cmd = new SqlCommand("sp_insertar_cotizacion", conn);
					cmd.CommandType = CommandType.StoredProcedure;

					// Agregamos los parámetros exactamente como los definimos en el SP
					cmd.Parameters.AddWithValue("@id_cliente", idCli);
					cmd.Parameters.AddWithValue("@id_tasa", idTas);
					cmd.Parameters.AddWithValue("@id_impuesto", idImp);
					cmd.Parameters.AddWithValue("@monto", mon);
					cmd.Parameters.AddWithValue("@interes_bruto_total", bruto);
					cmd.Parameters.AddWithValue("@impuesto_total", impTotal);
					cmd.Parameters.AddWithValue("@neto_total", neto);
					cmd.Parameters.AddWithValue("@id_usuario", idUsu);

					conn.Open();
					int filasAfectadas = cmd.ExecuteNonQuery();

					// Si devuelve más de 0, la inserción fue exitosa
					return filasAfectadas > 0;
				}
			}
			catch (Exception ex)
			{
				// Registramos el error o lo lanzamos para capturarlo en la Vista
				throw new Exception("Error en CotizacionController: " + ex.Message);
			}
		}
    }
}