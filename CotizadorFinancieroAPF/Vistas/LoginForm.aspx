<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginForm.aspx.cs" Inherits="CotizadorFinancieroAPF.Vistas.LoginForm" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login - Cotizador Financiero</title>

    <!-- BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- ICONOS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet" />

    <style>
        body {
            background: #f4f6f9;
        }

        .login-card {
            border-radius: 15px;
        }

        .logo {
            width: 80px;
        }

        .form-control:focus {
            box-shadow: 0 0 0 0.2rem rgba(13,110,253,.25);
        }
    </style>
</head>

<body>

<form id="form1" runat="server">

    <div class="container vh-100 d-flex justify-content-center align-items-center">

        <div class="card shadow-lg border-0 login-card" style="width:100%; max-width:420px;">

            <div class="card-body p-4">

                <!-- LOGO -->
                <div class="text-center mb-4">
                    <img src="../Images/LogoCotizadorAPF.png" class="logo" />
                    <h4 class="mt-3 fw-bold text-primary">Cotizador Financiero</h4>
                    <small class="text-muted">Acceso al sistema</small>
                </div>

                <!-- CORREO -->
                <div class="mb-3">
                    <label class="form-label fw-semibold">Correo</label>
                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="bi bi-envelope"></i>
                        </span>

                        <asp:TextBox ID="txtCorreo" runat="server"
                            CssClass="form-control"
                            placeholder="Ingrese su correo" />
                    </div>
                </div>

                <!-- CONTRASEÑA -->
                <div class="mb-3">
                    <label class="form-label fw-semibold">Contraseña</label>

                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="bi bi-lock"></i>
                        </span>

                        <asp:TextBox ID="txtContrasenia" runat="server"
                            CssClass="form-control"
                            TextMode="Password"
                            placeholder="Ingrese su contraseña" />

                        <button type="button" class="btn btn-outline-secondary" onclick="togglePassword()">
                            <i class="bi bi-eye"></i>
                        </button>
                    </div>
                </div>

                <!-- MENSAJE -->
                <asp:Label ID="lblMensaje" runat="server"
                    CssClass="text-danger text-center d-block mb-2" />

                <!-- BOTON -->
                <div class="d-grid mt-3">
                    <asp:Button ID="btnLogin" runat="server"
                       Text="Iniciar Sesión"
                       CssClass="btn btn-primary btn-lg fw-semibold"
                       OnClick="btnLogin_Click"
                       OnClientClick="return validarLogin();" />
                </div>

                <div class="text-center mt-3">
                    <span class="text-muted">¿No tienes cuenta?</span>
                    <asp:LinkButton ID="btnRegistrarse" runat="server"
                        CssClass="fw-semibold text-primary ms-1"
                        OnClick="btnRegistrarse_Click">
                        Registrarse
                    </asp:LinkButton>
                </div>

            </div>

            <div class="card-footer text-center bg-white border-0 pb-3">
                <small class="text-muted">
                    © 2026 Cotizador Financiero
                </small>
            </div>

        </div>

    </div>

</form>

<!-- BOOTSTRAP JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- MOSTRAR PASSWORD -->
<script>
    function togglePassword() {
        var txt = document.getElementById('<%= txtContrasenia.ClientID %>');

        if (txt.type === "password") {
            txt.type = "text";
        } else {
            txt.type = "password";
        }
    }
</script>

    <script>
        // Procedimiento para poder iniciar sesión con la tecla enter
        document.addEventListener("DOMContentLoaded", function () {

            document.addEventListener("keypress", function (e) {
                if (e.key === "Enter") {
                    e.preventDefault();
                    validarLogin();
                }
            });

        });

        // Validacion de campos antes de enviar 
        function validarLogin() {

            var correo = document.getElementById('<%= txtCorreo.ClientID %>').value.trim();
        var pass = document.getElementById('<%= txtContrasenia.ClientID %>').value.trim();
        var lbl = document.getElementById('<%= lblMensaje.ClientID %>');

        
        lbl.innerText = "";

        // validacion de campos vacíos
        if (correo === "" || pass === "") {
            lbl.innerText = "Debe completar todos los campos.";
            return false;
        }

        // Validacion de formato de correo
        var regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        if (!regex.test(correo)) {
            lbl.innerText = "Ingrese un correo válido.";
            return false;
        }

        document.getElementById('<%= btnLogin.ClientID %>').click();
        }
    </script>

</body>
</html>