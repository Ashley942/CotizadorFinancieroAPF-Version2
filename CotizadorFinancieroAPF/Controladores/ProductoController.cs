using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using CotizadorFinancieroAPF.Modelos;

namespace ExmMantFacturas.Controladores
{
    public class ProductoController
    {
        private string connectionString;

        public ProductoController()
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

        // INSERTAR PRODUCTO
        public int InsertarProducto(ProductoClass producto)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand("sp_insertar_producto", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

              
                    cmd.Parameters.AddWithValue("@nombre_producto", producto.Nombre);
                    cmd.Parameters.AddWithValue("@id_producto", producto.IdProducto);

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
                throw new Exception("Error de base de datos al insertar producto: " + ex.Message, ex);
            }
            catch (Exception ex)
            {
                throw new Exception("Error al insertar producto: " + ex.Message, ex);
            }
        }

        // ACTUALIZAR PRODUCTO
        public int ActualizarProducto(ProductoClass producto)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand("sp_actualizar_producto", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@id_producto", producto.IdProducto);
                    cmd.Parameters.AddWithValue("@id_moneda", producto.IdMoneda);
                    cmd.Parameters.AddWithValue("@nombre_producto", producto.Nombre);

                   
                    SqlParameter retorno = new SqlParameter();
                    retorno.ParameterName = "@RETURN_VALUE";
                    retorno.SqlDbType = SqlDbType.Int;
                    retorno.Direction = ParameterDirection.ReturnValue;

                    cmd.Parameters.Add(retorno);

                    conn.Open();
                    cmd.ExecuteNonQuery();

                    return Convert.ToInt32(retorno.Value);
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al actualizar producto: " + ex.Message);
            }
        }

        // CAMBIAR ESTADO PRODUCTO
        public int CambiarEstadoProducto(int idProducto)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand("sp_estado_producto", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@id_producto", idProducto);

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
                throw new Exception("Error de base de datos al cambiar estado del producto: " + ex.Message, ex);
            }
            catch (Exception ex)
            {
                throw new Exception("Error al cambiar estado del producto: " + ex.Message, ex);
            }
        }

        //Listar Monedas 
        public DataTable ListarMonedas()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand("sp_listar_ctg_monedas", conn))
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
            catch (Exception ex)
            {
                throw new Exception("Error al listar monedas: " + ex.Message);
            }
        }

        /*public string ObtenerSimboloPorProducto(int idProducto)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand("sp_obtener_moneda_producto", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@idProducto", idProducto);

                conn.Open();
                return cmd.ExecuteScalar().ToString();
            }
        }*/

        // LISTAR PRODUCTOS
        public DataTable ListarProductos()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand("sp_listar_productos", conn))
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
                throw new Exception("Error de base de datos al listar productos: " + ex.Message, ex);
            }
            catch (Exception ex)
            {
                throw new Exception("Error al listar productos: " + ex.Message, ex);
            }
        }
    }
}