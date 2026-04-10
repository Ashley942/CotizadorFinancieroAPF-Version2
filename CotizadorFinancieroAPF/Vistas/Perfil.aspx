<%@ Page Title="" Language="C#" MasterPageFile="~/Vistas/PaginaMaestra.master" AutoEventWireup="true" CodeBehind="Perfil.aspx.cs" Inherits="CotizadorFinancieroAPF.Vistas.Perfil" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<div class="container mt-4">
    
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h4>Mi Perfil</h4>
        </div>

        <div class="card-body">

            <div class="row mb-3">
                <div class="col-md-6">
                    <label>Nombre:</label>
                    <asp:Label ID="lblNombre" runat="server" CssClass="form-control"></asp:Label>
                </div>

                <div class="col-md-6">
                    <label>Correo:</label>
                    <asp:Label ID="lblCorreo" runat="server" CssClass="form-control"></asp:Label>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label>Identificación:</label>
                    <asp:Label ID="lblIdentificacion" runat="server" CssClass="form-control"></asp:Label>
                </div>

                <div class="col-md-6">
                    <label>Teléfono:</label>
                    <asp:Label ID="lblTelefono" runat="server" CssClass="form-control"></asp:Label>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <label>Rol:</label>
                    <asp:Label ID="lblRol" runat="server" CssClass="form-control"></asp:Label>
                </div>
            </div>

        </div>
    </div>

</div>

</asp:Content>
