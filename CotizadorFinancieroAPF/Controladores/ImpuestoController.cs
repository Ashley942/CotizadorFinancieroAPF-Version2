using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using CotizadorFinancieroAPF.Modelos;

namespace CotizadorFinancieroAPF.Controladores
{
    public class ImpuestoController
    {
        private string connectionString;

        public ImpuestoController()
        {
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

        // INSERTAR IMPUESTO
        public int InsertarImpuesto(CatalogoImpuestoClass impuesto)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand("sp_insertar_ctg_impuesto", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    
                    cmd.Parameters.AddWithValue("@impuesto", impuesto.Impuesto);

                    conn.Open();
                    cmd.ExecuteNonQuery();

                    return 1; // éxito
                }
            }
            catch (SqlException ex)
            {
                throw new Exception("Error de base de datos al insertar impuesto: " + ex.Message, ex);
            }
            catch (Exception ex)
            {
                throw new Exception("Error al insertar impuesto: " + ex.Message, ex);
            }
        }

        // ACTUALIZAR IMPUESTO
        public int ActualizarImpuesto(CatalogoImpuestoClass impuesto)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand("sp_actualizar_ctg_impuesto", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@id_impuesto", impuesto.IdImpuesto);
                    cmd.Parameters.AddWithValue("@impuesto", impuesto.Impuesto);

                    conn.Open();
                    cmd.ExecuteNonQuery();

                    return 1;
                }
            }
            catch (SqlException ex)
            {
                throw new Exception("Error de base de datos al actualizar impuesto: " + ex.Message, ex);
            }
            catch (Exception ex)
            {
                throw new Exception("Error al actualizar impuesto: " + ex.Message, ex);
            }
        }

        // CAMBIAR ESTADO
        public int CambiarEstadoImpuesto(int idImpuesto)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand("sp_estado_ctg_impuesto", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@id_impuesto", idImpuesto);

                    SqlParameter retorno = new SqlParameter("@resultado", SqlDbType.Int);
                    retorno.Direction = ParameterDirection.Output;

                    cmd.Parameters.Add(retorno);

                    conn.Open();
                    cmd.ExecuteNonQuery();

                    return Convert.ToInt32(retorno.Value);
                }
            }
            catch (SqlException ex)
            {
                throw new Exception("Error de base de datos al cambiar estado del impuesto: " + ex.Message, ex);
            }
            catch (Exception ex)
            {
                throw new Exception("Error al cambiar estado del impuesto: " + ex.Message, ex);
            }
        }

        // LISTAR IMPUESTOS
        public DataTable ListarImpuestos()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand("sp_listar_ctg_impuestos", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        return dt;
                    }
                }
            }
            catch (SqlException ex)
            {
                throw new Exception("Error de base de datos al listar impuestos: " + ex.Message, ex);
            }
            catch (Exception ex)
            {
                throw new Exception("Error al listar impuestos: " + ex.Message, ex);
            }
        }
    }
}