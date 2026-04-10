<%@ Page Title="" Language="C#" MasterPageFile="~/Vistas/PaginaMaestra.master" AutoEventWireup="true" CodeBehind="PaginaAdmin.aspx.cs" Inherits="CotizadorFinancieroAPF.Vistas.PaginaAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

    <div class="container-fluid">
        <div class="row">

            <!-- SIDEBAR -->
            <div class="col-md-3 col-lg-2 bg-dark text-white vh-100 p-3">
                <h4 class="text-center">Menú</h4>
                <hr />

                <ul class="nav flex-column">

                    <li class="nav-item mb-2">
                        <a class="nav-link text-white" href="#">
                            🏠 Inicio
                        </a>
                    </li>

                    <li class="nav-item mb-2">
                        <a class="nav-link text-white" href="Usuarios.aspx">
                            👥 Gestión de Usuarios
                        </a>
                    </li>

                    <li class="nav-item mb-2">
                        <a class="nav-link text-white" href="#">
                            📊 Reportes
                        </a>
                    </li>

                    <li class="nav-item mt-4">
                        <asp:LinkButton ID="btnLogout" runat="server" CssClass="btn btn-danger w-100" OnClick="btnLogout_Click">
                            Cerrar Sesión
                        </asp:LinkButton>
                    </li>

                </ul>
            </div>

            <!-- CONTENIDO -->
            <div class="col-md-9 col-lg-10 p-4">

                <h2>Bienvenido al Sistema</h2>
                <p>Selecciona una opción del menú para continuar.</p>

                <!-- Tarjetas -->
                <div class="row mt-4">

                    <div class="col-md-4">
                        <div class="card shadow">
                            <div class="card-body text-center">
                                <h5>Usuarios</h5>
                                <p>Administrar usuarios del sistema</p>
                                <a href="Usuarios.aspx" class="btn btn-primary">Ir</a>
                            </div>
                        </div>
                    </div>

                </div>

            </div>

        </div>
    </div>

</asp:Content>