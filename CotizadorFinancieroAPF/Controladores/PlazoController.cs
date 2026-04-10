using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using CotizadorFinancieroAPF.Modelos;

namespace CotizadorFinancieroAPF.Controladores
{
    public class PlazoController
    {

        private string connectionString;


        public PlazoController()
        {
            // Obtener la cadena de conexión desde Web.config
         
            try
            {
                connectionString = ConfigurationManager
                    .ConnectionStrings["Conexion"].ConnectionString;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener la cadena de conexión: " + ex.Message, ex);
            }
        }

        /// <summary>
        /// Obtiene todos los plazos disponibles
        /// </summary>
        public List<CatalogoPlazoClass> ListarPlazos()
        {
            List<CatalogoPlazoClass> lista = new List<CatalogoPlazoClass>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand("sp_listar_ctg_plazos", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                conn.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        lista.Add(new CatalogoPlazoClass
                        {
                            IdPlazo = Convert.ToInt32(dr["id_plazo"]),
                            Plazo = Convert.ToInt32(dr["plazo"]),
                            UnidadPlazo = Convert.ToChar(dr["unidad"]),
                            Estado = Convert.ToBoolean(dr["estado"]),
                        });
                    }
                }
            }

            return lista;
        }

        public int InsertarPlazo(CatalogoPlazoClass plazo)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand("sp_insertar_ctg_plazo", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@plazo", plazo.Plazo);
                cmd.Parameters.AddWithValue("@unidad", plazo.UnidadPlazo);

                cmd.Parameters.Add("@RETURN_VALUE", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;

                conn.Open();
                cmd.ExecuteNonQuery();

                return Convert.ToInt32(cmd.Parameters["@RETURN_VALUE"].Value);
            }
        }


        public int ActualizarPlazo(CatalogoPlazoClass plazo)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand("sp_actualizar_ctg_plazo", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@id_plazo", SqlDbType.Int).Value = plazo.IdPlazo;
                cmd.Parameters.Add("@plazo", SqlDbType.Int).Value = plazo.Plazo;
                cmd.Parameters.Add("@unidad", SqlDbType.Char, 1).Value = plazo.UnidadPlazo.ToString();

                cmd.Parameters.Add("@RETURN_VALUE", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;

                conn.Open();
                cmd.ExecuteNonQuery();

                return Convert.ToInt32(cmd.Parameters["@RETURN_VALUE"].Value);
            }
        }

        public void CambiarEstado(int idPlazo)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand("sp_estado_ctg_plazo", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@id_plazo", idPlazo);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

    }
}