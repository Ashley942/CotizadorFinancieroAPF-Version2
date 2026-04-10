<%@ Page Title="" Language="C#" MasterPageFile="~/Vistas/PaginaMaestra.Master" AutoEventWireup="true" CodeBehind="HistorialCotizaciones.aspx.cs" Inherits="CotizadorFinancieroAPF.Vistas.HistorialCotizaciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<div class="container mt-4">

    <div class="card shadow">
        <div class="card-header bg-dark text-white">
            <h4>Historial de Cotizaciones</h4>
        </div>

        <div class="card-body">


            <div class="row mb-3">
                <div class="col-md-4">
                    <asp:TextBox ID="txtFiltroUsuario" runat="server"
                        CssClass="form-control"
                        placeholder="Buscar por usuario..." />
                </div>

                <div class="col-md-2">
                    <asp:Button ID="btnBuscar" runat="server"
                        Text="Buscar"
                        CssClass="btn btn-primary"
                        OnClick="btnBuscar_Click" />
                </div>
            </div>

            
            <asp:GridView ID="gvCotizaciones" runat="server"
                CssClass="table table-striped table-hover"
                AutoGenerateColumns="false">

                <Columns>
                    <asp:BoundField DataField="id_cotizacion" HeaderText="#" />
                    <asp:BoundField DataField="nombre_usuario" HeaderText="Usuario" />
                    <asp:BoundField DataField="nombre_producto" HeaderText="Producto" />
                    <asp:BoundField DataField="monto" HeaderText="Monto" DataFormatString="{0:N2}" />
                    <asp:BoundField DataField="plazo" HeaderText="Plazo" />
                    <asp:BoundField DataField="tasa" HeaderText="Tasa (%)" />
                    <asp:BoundField DataField="neto_total" HeaderText="Neto" DataFormatString="{0:N2}" />
                    <asp:BoundField DataField="fecha_creacion" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy}" />
                </Columns>

            </asp:GridView>

        </div>
    </div>
</div>
</asp:Content>