<%@ Page Title="" Language="C#" MasterPageFile="~/Vistas/PaginaMaestra.master" AutoEventWireup="true" CodeBehind="Cotizacion.aspx.cs" Inherits="CotizadorFinancieroAPF.Vistas.Cotizacion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<div class="container mt-5">

    <div class="card shadow-lg border-0">

        
        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
            <h4 class="mb-0">🧾 Nueva Cotización</h4>
        </div>

        <div class="card-body p-4">

            
            <div class="row mb-4">

                <asp:HiddenField ID="hfIdCliente" runat="server" />

                <div class="col-md-6">
                    <label class="form-label fw-semibold">Cliente</label>
                    <asp:TextBox ID="txtCliente" runat="server"
                        CssClass="form-control form-control-lg"
                        ReadOnly="true"></asp:TextBox>
                </div>

                <div class="col-md-6">
                    <label class="form-label fw-semibold">Correo</label>
                    <asp:TextBox ID="txtCorreo" runat="server"
                        CssClass="form-control form-control-lg"
                        ReadOnly="true"></asp:TextBox>
                </div>

            </div>


            <div class="row mb-4">

                <div class="col-md-6">
                    <label class="form-label fw-semibold">Producto</label>
                    <asp:DropDownList ID="ddlProducto" runat="server"
                        CssClass="form-select form-select-lg"
                        AutoPostBack="true"
                        OnSelectedIndexChanged="ddlProducto_SelectedIndexChanged">
                    </asp:DropDownList>
                </div>

                <div class="col-md-6">
                    <label class="form-label fw-semibold">Monto</label>

                    <div class="input-group input-group-lg">

                        <span id="lblSimbolo" runat="server" class="input-group-text">₡</span>
                        <asp:TextBox ID="txtMonto" runat="server"
                            CssClass="form-control"
                            placeholder="Ej: 50,000,000">
                        </asp:TextBox>
                    </div>

                    <asp:RegularExpressionValidator
                        ControlToValidate="txtMonto"
                        ValidationExpression="^\d+(\.\d{1,2})?$"
                        ErrorMessage="Ingrese un monto válido"
                        CssClass="text-danger small"
                        runat="server" />
                </div>

            </div>

            
            <div class="row mb-4">

                <div class="col-md-6">
                    <label class="form-label fw-semibold">Plazo</label>
                    <asp:DropDownList ID="ddlPlazo" runat="server"
                        CssClass="form-select form-select-lg"
                        AutoPostBack="true"
                        OnSelectedIndexChanged="ddlPlazo_SelectedIndexChanged">
                    </asp:DropDownList>
                </div>

                <div class="col-md-6">
                    <label class="form-label fw-semibold">Tasa (%)</label>

                    <div class="input-group input-group-lg">
                        <asp:TextBox ID="txtTasa" runat="server"
                            CssClass="form-control text-end"
                            ReadOnly="true">
                        </asp:TextBox>
                        <span class="input-group-text">%</span>
                    </div>
                </div>

                <div class="col-md-4">
                  <label class="form-label fw-semibold">Impuesto</label>

                    <div class="input-group input-group-lg">
                        <asp:DropDownList ID="ddlImpuesto" runat="server"
                            CssClass="form-select text-end">
                        </asp:DropDownList>
                        <span class="input-group-text">%</span>
                    </div>
                </div>
            </div>

            
            <div class="d-flex justify-content-end">
                <asp:Button ID="btnCalcular" runat="server"
                    Text="💰 Calcular Cotización"
                    CssClass="btn btn-success btn-lg px-4 shadow-sm"
                    OnClick="btnCalcular_Click" />
            </div>

            <hr />

<!-- Resultados para la cotización -->
<asp:Panel ID="pnlResultado" runat="server" Visible="false">

    <div class="card shadow mt-4 border-0">

        <div class="card-header bg-dark text-white d-flex justify-content-between align-items-center">
            <div>
                <h5 class="mb-0">Comprobante de Cotización</h5>
                <small>Sistema Financiero</small>
            </div>

            <asp:Label ID="lblNumeroCotizacion" runat="server"
                CssClass="fw-bold fs-5 text-warning">
            </asp:Label>
        </div>

        <div class="card-body">

            <div class="row mb-4">
                <div class="col-md-6">
                    <label class="text-muted small">Cliente</label>
                    <asp:Label ID="lblClienteResumen" runat="server" CssClass="fw-semibold d-block"></asp:Label>
                </div>

                <div class="col-md-6">
                    <label class="text-muted small">Correo</label>
                    <asp:Label ID="lblCorreoResumen" runat="server" CssClass="fw-semibold d-block"></asp:Label>
                </div>
            </div>

            <div class="row mb-4">
                <div class="col-md-3">
                    <label class="text-muted small">Producto</label>
                    <asp:Label ID="lblProductoResumen" runat="server" CssClass="fw-semibold d-block"></asp:Label>
                </div>

                <div class="col-md-3">
                    <label class="text-muted small">Monto</label>
                    <asp:Label ID="lblMontoResumen" runat="server" CssClass="fw-semibold d-block"></asp:Label>
                </div>

                <div class="col-md-3">
                    <label class="text-muted small">Plazo</label>
                    <asp:Label ID="lblPlazoResumen" runat="server" CssClass="fw-semibold d-block"></asp:Label>
                </div>

                <div class="col-md-3">
                    <label class="text-muted small">Tasa</label>
                    <asp:Label ID="lblTasaResumen" runat="server" CssClass="fw-semibold d-block"></asp:Label>
                    <asp:HiddenField ID="hfIdTasa" runat="server" />
                </div>
            </div>


            <div class="mb-4">
                <label class="text-muted small">Impuesto Aplicado</label>
                <asp:Label ID="lblImpuestoResumen" runat="server" CssClass="fw-semibold d-block"></asp:Label>
            </div>

           
            <div class="table-responsive mb-4">
                <asp:GridView ID="gvDetalle" runat="server"
                    CssClass="table table-bordered table-hover text-center" AutoGenerateColumns="false" ShowFooter="true" OnRowDataBound="gvDetalle_RowDataBound">

                <Columns>

                    <asp:BoundField DataField="Mes" HeaderText="Mes" />

                    <asp:BoundField DataField="Monto" HeaderText="Monto" DataFormatString="{0:N2}" HtmlEncode="false" ItemStyle-HorizontalAlign="Center" />

                    <asp:BoundField DataField="InteresBruto" HeaderText="Interés Bruto" DataFormatString="{0:N2}" HtmlEncode="false" ItemStyle-HorizontalAlign="Center"/>

                    <asp:BoundField DataField="Impuesto" HeaderText="Impuesto" DataFormatString="{0:N2}" HtmlEncode="false" ItemStyle-HorizontalAlign="Center" />

                    <asp:BoundField DataField="InteresNeto" HeaderText="Neto" DataFormatString="{0:N2}" HtmlEncode="false" ItemStyle-HorizontalAlign="Center" />

                </Columns>

                </asp:GridView>
            </div>

        </div>

    </div>
    <div class="text-end mt-3">
        <asp:Button ID="btnNueva" runat="server" Text="Nueva Cotización" CssClass="btn btn-outline-primary btn-lg px-4" OnClick="btnNueva_Click" />
    </div>
</asp:Panel>

        </div>
    </div>

</div>

<script> 
    document.addEventListener("DOMContentLoaded", function () {

            const ddl = document.getElementById("<%= ddlProducto.ClientID %>");
        const simbolo = document.getElementById("lblSimbolo");

        function actualizarSimbolo() {
            let selected = ddl.options[ddl.selectedIndex];
            let simboloMoneda = selected.getAttribute("data-simbolo");

            if (simboloMoneda) {
                simbolo.innerText = simboloMoneda;
            }
        }

        ddl.addEventListener("change", actualizarSimbolo());

        actualizarSimbolo();
    });
</script>


</asp:Content>

