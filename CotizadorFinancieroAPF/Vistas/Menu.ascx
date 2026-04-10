<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Menu.ascx.cs" Inherits="CotizadorFinancieroAPF.Vistas.Menu" %>

<link href="../Estilos/CotizadorEstilos.css" rel="stylesheet" />

<div class="bg-dark text-white p-3" style="min-height:500px; border-radius:10px;">

    <h5 class="text-center">Menú</h5>
    <hr style="border-color:white;" />

    <ul class="nav flex-column sidebar-menu">

        
        <li>
            <asp:LinkButton ID="btnInicio" runat="server" CssClass="nav-link" OnClick="btnInicio_Click">
               <span class="icon"> 🏠 </span> Inicio
            </asp:LinkButton>
        </li>

        
        <li id="menuUsuarios" runat="server">
            <asp:LinkButton ID="btnUsuarios" runat="server" CssClass="nav-link" OnClick="btnUsuarios_Click">
                <span class="icon">👥</span> Gestión de Usuarios
            </asp:LinkButton>
        </li>

        <li id="menuProductos" runat="server">
            <asp:LinkButton ID="btnProductos" runat="server" CssClass="nav-link" OnClick="btnProductos_Click">
                <span class="icon">📦</span> Gestión de Productos
            </asp:LinkButton>
        </li>

        <li>
            <asp:LinkButton ID="btnPerfil" runat="server" CssClass="nav-link" OnClick="btnPerfil_Click">
                <span class="icon">👤</span> Mi Perfil
            </asp:LinkButton>
        </li>

        <li id="menuTasas" runat="server">
            <asp:LinkButton ID="btnTasas" runat="server" CssClass="nav-link" OnClick="btnTasas_Click">
                <span class="icon">📊</span> Tasas
            </asp:LinkButton>
        </li>

         <li id="menuPlazos" runat="server">
            <asp:LinkButton ID="btnPlazos" runat="server" CssClass="nav-link" OnClick="btnPlazos_Click">
                <span class="icon">📅</span> Plazos
            </asp:LinkButton>
        </li>

        <li id="menuImpuestos" runat="server">
            <asp:LinkButton ID="btnImpuestos" runat="server" CssClass="nav-link" OnClick="btnImpuestos_Click">
                <span class="icon">💰</span> Impuestos
            </asp:LinkButton>
        </li>

        <li id="menuHistorial" runat="server">
            <asp:LinkButton ID="btnHistorial" runat="server" CssClass="nav-link" OnClick="btnHistorial_Click">
                <span class="icon">📋</span> Historial de Cotizaciones
            </asp:LinkButton>
        </li>
        
        <li>
            <asp:LinkButton ID="btnCotizacion" runat="server" CssClass="nav-link" OnClick="btnCotizacion_Click">
                <span class="icon">📋</span> Cotización
            </asp:LinkButton>
        </li>

        <li class="nav-item mt-4">
            <asp:LinkButton ID="btnLogout" runat="server" CssClass="btn btn-danger w-100" OnClick="btnLogout_Click">
                Cerrar Sesión
            </asp:LinkButton>
        </li>

    </ul>

</div>