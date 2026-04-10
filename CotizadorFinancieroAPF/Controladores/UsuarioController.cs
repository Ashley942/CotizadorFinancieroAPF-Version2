using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using CotizadorFinancieroAPF.Modelos;

namespace CotizadorFinancieroAPF.Controladores
{
    public class UsuarioController
    {

        private string connectionString;


        public UsuarioController()
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

        public int RegistrarUsuario(UsuarioClass nuevo)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand("sp_insertar_usuario", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@id_rol", 1);
                    cmd.Parameters.AddWithValue("@identificacion", nuevo.Identificacion);
                    cmd.Parameters.AddWithValue("@nombre_usuario", nuevo.Nombre);
                    cmd.Parameters.AddWithValue("@contrasenia", nuevo.Contrasena);
                    cmd.Parameters.AddWithValue("@telefono", nuevo.Telefono);
                    cmd.Parameters.AddWithValue("@correo", nuevo.Correo);
                    
                    // Capturar el RETURN del SP
                    var returnValue = cmd.Parameters.Add("@ReturnVal", SqlDbType.Int);
                    returnValue.Direction = ParameterDirection.ReturnValue;


                    con.Open();
                    cmd.ExecuteNonQuery();

                    int resultado = (int)(returnValue.Value ?? 0);
                    return resultado; 
                }
            } 
            catch (Exception ex)
            {
                Console.WriteLine($"Error: {ex.Message}");
                Console.WriteLine($"Detalle: {ex.StackTrace}");
                return -1; 
            }
        }

        // Valida el login comparando la contraseña ingresada con la almacenada en la base de datos y devuelve el usuario si es correcto

        public UsuarioClass ValidarLogin(string correo, string pass)
        {
            UsuarioClass usuario = null;
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
            
                    SqlCommand cmd = new SqlCommand("sp_listar_usuario_por_correo", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@correo", correo);

                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        //Obtenemos la contra encriptada de la DB
                        byte[] passBD = (byte[])dr["contrasenia"];

                        // Pasamos la contraseña ingresada por el mismo proceso de encriptación para compararla con la almacenada en la DB
                        if (VerificarHash(pass, passBD))
                        {
                            usuario = new UsuarioClass
                            {
                                IdUsuario = Convert.ToInt32(dr["id_usuario"]), // Nombre exacto del SQL
                                Nombre = dr["nombre_usuario"].ToString(),
                                Rol = dr["nombre_rol"].ToString(),
                                Correo = dr["Correo"].ToString()
                            };
                        }
                    }
                }
            }
            catch (Exception) { throw; }
            return usuario;
        }

        public List<UsuarioClass> ListarUsuarios()
        {
            List<UsuarioClass> lista = new List<UsuarioClass>();

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("sp_listar_usuarios", con);
                cmd.CommandType = CommandType.StoredProcedure;

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    lista.Add(new UsuarioClass
                    {
                        IdUsuario = Convert.ToInt32(dr["id_usuario"]),
                        Nombre = dr["nombre_usuario"].ToString(),
                        IdRol = Convert.ToInt32(dr["id_rol"]),
                        Rol = dr["rol"].ToString()
                    });
                }
            }

            return lista;
        }

        public DataTable ListarRoles()
        {
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT id_rol, rol FROM CatalogoRoles", con);

                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }

            return dt;
        }

        public int ActualizarUsuario(UsuarioClass usuario)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("sp_actualizar_usuario", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@id_usuario", usuario.IdUsuario);
                cmd.Parameters.AddWithValue("@id_rol", usuario.IdRol);
                cmd.Parameters.AddWithValue("@nombre_usuario", usuario.Nombre);

                if (!string.IsNullOrEmpty(usuario.Contrasena))
                    cmd.Parameters.AddWithValue("@contrasenia", usuario.Contrasena);
                else
                    cmd.Parameters.AddWithValue("@contrasenia", DBNull.Value);

                var returnValue = cmd.Parameters.Add("@ReturnVal", SqlDbType.Int);
                returnValue.Direction = ParameterDirection.ReturnValue;

                con.Open();
                cmd.ExecuteNonQuery();

                return (int)returnValue.Value;
            }
        }

        public UsuarioClass ObtenerUsuarioPorCorreo(string correo)
        {
            UsuarioClass usuario = null;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("sp_listar_usuario_por_correo", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@correo", correo);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    usuario = new UsuarioClass
                    {
                        IdUsuario = Convert.ToInt32(dr["id_usuario"]),
                        Nombre = dr["nombre_usuario"].ToString(),
                        Correo = dr["correo"].ToString(),
                        Identificacion = dr["identificacion"].ToString(),
                        Telefono = dr["telefono"].ToString(),
                        IdRol = Convert.ToInt32(dr["id_rol"]),
                        Rol = dr["nombre_rol"].ToString()
                    };
                }
            }

            return usuario;
        }

        private bool VerificarHash(string passIngresada, byte[] hashBD)
        {
            using (var sha256 = System.Security.Cryptography.SHA256.Create())
            {
                // La contrasenia ingresada se encripta y vemos si coincide con la encriptada obtenida en la DB
                // Usar Unicode para que coincida con el proceso de encriptación al registrar el usuario
                byte[] hashIngresado = sha256.ComputeHash(System.Text.Encoding.UTF8.GetBytes(passIngresada));
                return StructuralComparisons.StructuralEqualityComparer.Equals(hashIngresado, hashBD);
            }
        }
    }
}