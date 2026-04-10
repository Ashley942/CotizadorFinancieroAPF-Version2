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

    public class ClienteController
    {
        private string connectionString;

        public ClienteController()
        {
            try
            {
                connectionString = ConfigurationManager.ConnectionStrings["Conexion"].ConnectionString;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener la cadena de conexión: " + ex.Message, ex);
            }
        }

        // INSERTAR CLIENTE
        public int InsertarCliente(ClienteClass cliente)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand("sp_insertar_cliente", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@nombre", cliente.Nombre);
                    cmd.Parameters.AddWithValue("@identificacion", cliente.Identificacion);
                    cmd.Parameters.AddWithValue("@telefono", cliente.Telefono);
                    cmd.Parameters.AddWithValue("@correo", cliente.Correo);
                   
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
                throw new Exception("Error de base de datos al insertar cliente: " + ex.Message, ex);
            }
            catch (Exception ex)
            {
                throw new Exception("Error al insertar cliente: " + ex.Message, ex);
            }
        }

        // ACTUALIZAR CLIENTE
        public int ActualizarCliente(ClienteClass cliente)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand("sp_actualizar_cliente", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@nombre", cliente.Nombre);
                    cmd.Parameters.AddWithValue("@identificacion", cliente.Identificacion);
                    cmd.Parameters.AddWithValue("@telefono", cliente.Telefono);
                    cmd.Parameters.AddWithValue("@correo", cliente.Correo);

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
                throw new Exception("Error de base de datos al actualizar cliente: " + ex.Message, ex);
            }
            catch (Exception ex)
            {
                throw new Exception("Error al actualizar cliente: " + ex.Message, ex);
            }
        }

        // CAMBIAR ESTADO CLIENTE
        public int CambiarEstadoCliente(int idCliente)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand("sp_estado_cliente", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@id_cliente", idCliente);

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
                throw new Exception("Error de base de datos al cambiar estado del cliente: " + ex.Message, ex);
            }
            catch (Exception ex)
            {
                throw new Exception("Error al cambiar estado del cliente: " + ex.Message, ex);
            }
        }

        // LISTAR CLIENTES
        public DataTable ListarClientes()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand("sp_listar_clientes", conn))
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
                throw new Exception("Error de base de datos al listar clientes: " + ex.Message, ex);
            }
            catch (Exception ex)
            {
                throw new Exception("Error al listar clientes: " + ex.Message, ex);
            }
        }

        // OBTENER CLIENTE POR ID
        public ClienteClass ObtenerClientePorIdentificacion(string identificacion)
        {
            ClienteClass cliente = null;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand("sp_listar_cliente_identificacion", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@identificacion", identificacion);

                    conn.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            cliente = new ClienteClass
                            {
                                IdCliente = Convert.ToInt32(dr["id_cliente"]),
                                Nombre = dr["nombre_cliente"].ToString(),
                                Identificacion = dr["identificacion"].ToString(),
                                Telefono = dr["telefono"].ToString(),
                                Correo = dr["correo"].ToString()
                            };
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener cliente por ID: " + ex.Message, ex);
            }

            return cliente;
        }
    }



}