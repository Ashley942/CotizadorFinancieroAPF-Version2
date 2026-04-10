using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using CotizadorFinancieroAPF.Modelos;

namespace CotizadorFinancieroAPF.Controladores
{
	/// <summary>
	/// Controlador encargado de gestionar la lógica de las tasas de interés.
	/// Conecta la base de datos con la interfaz de cotización.
	/// </summary>
	public class TasaController
	{
		private string connectionString;

		/// <summary>
		/// Constructor: Inicializa la cadena de conexión desde el Web.config.
		/// </summary>
		public TasaController()
		{
			try
			{
				// Busca la cadena llamada "Conexion" en el archivo de configuración
				connectionString = ConfigurationManager.ConnectionStrings["Conexion"].ConnectionString;
			}
			catch (Exception ex)
			{
				throw new Exception("Error al obtener la cadena de conexión: " + ex.Message, ex);
			}
		}

        public DataTable ListarTasas()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand("sp_listar_tasas", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    return dt;
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al listar tasas: " + ex.Message, ex);
            }
        }

       
        public TasaClass ObtenerTasa(int idProducto, int idPlazo)
		{
			TasaClass tasa = null;

			try
			{
				// El uso de 'using' asegura que la conexión se cierre automáticamente
				using (SqlConnection conn = new SqlConnection(connectionString))
				using (SqlCommand cmd = new SqlCommand("sp_obtener_tasa", conn))
				{
					cmd.CommandType = CommandType.StoredProcedure;

					// Parámetros que espera el SP en SQL Server
					cmd.Parameters.AddWithValue("@id_producto", idProducto);
					cmd.Parameters.AddWithValue("@id_plazo", idPlazo);

					conn.Open();

					using (SqlDataReader dr = cmd.ExecuteReader())
					{
						// Si el procedimiento devuelve una fila, mapeamos los datos
						if (dr.Read())
						{
							tasa = new TasaClass();

							// Conversión de tipos de datos de BD a C#
							tasa.IdTasa = Convert.ToInt32(dr["id_tasa"]);
							tasa.TasaValor = Convert.ToDecimal(dr["tasa"]);
						}
					}
				}
			}
			catch (SqlException ex)
			{
				// Captura errores específicos de SQL (conexión, permisos, etc.)
				throw new Exception("Error de base de datos al obtener tasa: " + ex.Message, ex);
			}
			catch (Exception ex)
			{
				// Captura errores generales de lógica
				throw new Exception("Error al obtener tasa: " + ex.Message, ex);
			}

			return tasa;
		}

        public int InsertarTasa(TasaClass tasa)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand("sp_insertar_tasa", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@id_producto", tasa.IdProducto);
                    cmd.Parameters.AddWithValue("@id_plazo", tasa.IdPlazo);
                    cmd.Parameters.AddWithValue("@tasa", tasa.TasaValor);

                    cmd.Parameters.Add("@RETURN_VALUE", SqlDbType.Int)
                        .Direction = ParameterDirection.ReturnValue;

                    conn.Open();
                    cmd.ExecuteNonQuery();

                    return Convert.ToInt32(cmd.Parameters["@RETURN_VALUE"].Value);
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al insertar tasa: " + ex.Message, ex);
            }
        }

        public int ActualizarTasa(TasaClass tasa)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand("sp_actualizar_tasa", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@id_tasa", tasa.IdTasa);
                    cmd.Parameters.AddWithValue("@id_producto", tasa.IdProducto);
                    cmd.Parameters.AddWithValue("@id_plazo", tasa.IdPlazo);
                    cmd.Parameters.AddWithValue("@tasa", tasa.TasaValor);

                    cmd.Parameters.Add("@RETURN_VALUE", SqlDbType.Int)
                        .Direction = ParameterDirection.ReturnValue;

                    conn.Open();
                    cmd.ExecuteNonQuery();

                    return Convert.ToInt32(cmd.Parameters["@RETURN_VALUE"].Value);
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al actualizar tasa: " + ex.Message, ex);
            }
        }

        public int CambiarEstadoTasa(int idTasa)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand("sp_estado_tasa", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@id_tasa", idTasa);

                    cmd.Parameters.Add("@RETURN_VALUE", SqlDbType.Int)
                        .Direction = ParameterDirection.ReturnValue;

                    conn.Open();
                    cmd.ExecuteNonQuery();

                    return Convert.ToInt32(cmd.Parameters["@RETURN_VALUE"].Value);
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al cambiar estado de tasa: " + ex.Message, ex);
            }
        }



    } 
} 