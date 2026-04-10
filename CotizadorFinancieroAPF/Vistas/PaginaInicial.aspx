<%@ Page Language="C#" MasterPageFile="~/Vistas/PaginaMaestra.master" AutoEventWireup="true" CodeBehind="PaginaInicial.aspx.cs" Inherits="CotizadorFinancieroAPF.Vistas.PaginaInicial" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="form-section">
        <div class="section-title"></div>

        <p>
            Este sistema permite gestionar productos financieros, tasas, clientes
            y realizar simulaciones de cotización.
        </p>
    </div>

    <div class="form-section">
        <div class="section-title">Accesos rápidos</div>

        <ul>
            <li>Registrar nuevos clientes</li>
            <li>Consultar productos financieros</li>
            <li>Simular cotizaciones</li>
            <li>Administrar tasas e impuestos</li>
        </ul>
    </div>

</asp:Content>