<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistroForm.aspx.cs" Inherits="CotizadorFinancieroAPF.Vistas.RegistroForm" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Registro - Sistema APF</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Iconos -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet" />

    <!-- Tus estilos -->
    <link href="../Estilos/LoginRegistroEstilos.css" rel="stylesheet" type="text/css" />

    <style>
        .login-container {
            border-radius: 15px;
        }

        .form-control:focus {
            box-shadow: 0 0 0 0.2rem rgba(13,110,253,.25);
        }

        .input-group-text {
            background-color: #fff;
        }

        .logo {
            width: 70px;
        }
    </style>
</head>

<body>

<form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <div class="container d-flex justify-content-center align-items-center min-vh-100">

        <div class="card shadow-lg p-4 login-container" style="max-width: 450px; width: 100%;">

           
            <div class="text-center mb-4">
                <img src="../Images/LogoCotizadorAPF.png" class="logo" />
                <h3 class="mt-3 fw-bold text-primary">Crear Cuenta</h3>
                <small class="text-muted">Complete los datos para registrarse</small>
            </div>

          
            <div class="mb-3">
                <asp:Label runat="server" Text="Identificación:" CssClass="form-label fw-semibold" />
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-card-text"></i></span>
                    <asp:TextBox ID="txtIdentificacion" runat="server" CssClass="form-control" />
                </div>
                <asp:RequiredFieldValidator ControlToValidate="txtIdentificacion"
                    ErrorMessage="La identificación es obligatoria"
                    CssClass="error-message" runat="server" Display="Dynamic" />
            </div>

           
            <div class="mb-3">
                <asp:Label runat="server" Text="Nombre:" CssClass="form-label fw-semibold" />
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-person"></i></span>
                    <asp:TextBox ID="txtNuevoUsuario" runat="server" CssClass="form-control" />
                </div>
                <asp:RequiredFieldValidator ControlToValidate="txtNuevoUsuario"
                    ErrorMessage="El nombre es obligatorio"
                    CssClass="error-message" runat="server" Display="Dynamic" />
            </div>

           
            <div class="mb-3">
                <asp:Label runat="server" Text="Correo:" CssClass="form-label fw-semibold" />
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                    <asp:TextBox ID="txtCorreo" runat="server" CssClass="form-control" />
                </div>
                <asp:RequiredFieldValidator ControlToValidate="txtCorreo"
                    ErrorMessage="El correo es obligatorio"
                    CssClass="error-message" runat="server" Display="Dynamic" />
                <asp:RegularExpressionValidator ControlToValidate="txtCorreo"
                    ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                    ErrorMessage="Correo inválido"
                    CssClass="error-message" runat="server" Display="Dynamic" />
            </div>

          
            <div class="mb-3">
                <asp:Label runat="server" Text="Contraseña:" CssClass="form-label fw-semibold" />
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-lock"></i></span>
                    <asp:TextBox ID="txtRegPass" runat="server" TextMode="Password" CssClass="form-control" />
                    <button type="button" class="btn btn-outline-secondary" onclick="togglePassword()">
                        <i class="bi bi-eye"></i>
                    </button>
                </div>
                <asp:RequiredFieldValidator ControlToValidate="txtRegPass"
                    ErrorMessage="La contraseña es obligatoria"
                    CssClass="error-message" runat="server" Display="Dynamic" />
            </div>

           
            <div class="mb-3">
                <asp:Label runat="server" Text="Número de teléfono:" CssClass="form-label fw-semibold" />
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-telephone"></i></span>
                    <asp:TextBox ID="txtTefelono" runat="server" CssClass="form-control" />
                </div>
                <asp:RequiredFieldValidator ControlToValidate="txtTefelono"
                    ErrorMessage="El teléfono es obligatorio"
                    CssClass="error-message" runat="server" Display="Dynamic" />
                <asp:RegularExpressionValidator ControlToValidate="txtTefelono"
                    ValidationExpression="^[0-9]{8,15}$"
                    ErrorMessage="Teléfono inválido"
                    CssClass="error-message" runat="server" Display="Dynamic" />
            </div>

            <div class="d-grid gap-2 mt-3">

                <asp:Button ID="btnRegister" runat="server"
                    Text="Crear Cuenta"
                    CssClass="btn btn-primary btn-lg fw-semibold"
                    OnClick="btnRegister_Click" />

                <asp:HyperLink ID="hlIrVista" runat="server"
                    NavigateUrl="~/Vistas/LoginForm.aspx"
                    CssClass="btn btn-outline-secondary text-center fw-semibold"
                    Text="Volver al Login" />

            </div>

           
            <div class="mt-3 text-center">
                <asp:Label ID="lblMensaje" runat="server" CssClass="error-message" />
            </div>

        </div>
    </div>

</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>


<script>
    function togglePassword() {
        var txt = document.getElementById('<%= txtRegPass.ClientID %>');
        txt.type = txt.type === "password" ? "text" : "password";
    }
</script>

</body>
</html>