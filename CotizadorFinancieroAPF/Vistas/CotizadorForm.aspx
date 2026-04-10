<%@ Page Language="C#" MasterPageFile="~/Vistas/PaginaMaestra.master"
    AutoEventWireup="true"
    CodeBehind="CotizadorForm.aspx.cs"
    Inherits="CotizadorFinancieroAPF.Vistas.CotizadorForm" %>

<%@ Register Src="~/Vistas/SelectorPlazosForm.ascx"
    TagPrefix="uc"
    TagName="SelectorPlazosForm" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="HeadContent" runat="server">
    
</asp:Content>

<asp:Content ID="ContentBody" ContentPlaceHolderID="MainContent" runat="server">

    <asp:HiddenField ID="hfldCliente" runat="server" Value="0" />
    <asp:HiddenField ID="hfldTasa"    runat="server" Value="0" />

    <div class="form-card">

        <!-- ═══ ENCABEZADO ═══ -->
        <div class="form-header">
            <div>
                <h1>Formulario de Cotización Financiera</h1>
                <p>Complete la información del cliente y del producto para generar la cotización.</p>
            </div>
        </div>

        <div class="form-body">

            <!-- ═══ SECCIÓN 1 · INFORMACIÓN DEL CLIENTE ═══ -->
            <div class="form-section">
                <div class="section-title">Información del Cliente</div>

                <div class="field-row">
                    <asp:Label runat="server" AssociatedControlID="txtNombre"
                        CssClass="field-label" Text="Nombre:" />
                    <asp:TextBox ID="txtNombre" runat="server"
                        CssClass="form-control readonly-field"
                        ReadOnly="true"
                        placeholder="Se llena al encontrar cliente" />
                </div>

                <div class="field-row">
                    <asp:Label runat="server" AssociatedControlID="txtIdentificacion"
                        CssClass="field-label" Text="Identificacion:" />
                    <asp:TextBox ID="txtIdentificacion" runat="server"
                        CssClass="form-control"
                        ReadOnly="true"
                        placeholder="Se llena al encontrar el cliente" />
                </div>

                <div class="field-row">
                    <asp:Label runat="server" AssociatedControlID="txtTelefono"
                        CssClass="field-label" Text="Teléfono:" />
                    <asp:TextBox ID="txtTelefono" runat="server"
                        CssClass="form-control readonly-field"
                        ReadOnly="true"
                        placeholder="Se llena al seleccionar cliente" />
                </div>

                <div class="field-row">
                    <asp:Label runat="server" AssociatedControlID="txtCorreo"
                        CssClass="field-label" Text="Correo:" />
                    <asp:TextBox ID="txtCorreo" runat="server"
                        CssClass="form-control readonly-field"
                        ReadOnly="true"
                        placeholder="Se llena al seleccionar cliente" />
                </div>
            </div>

            <hr class="form-divider" />

            <!-- ═══ SECCIÓN 2 · INFORMACIÓN DEL PRODUCTO ═══ -->
            <div class="form-section">
                <div class="section-title">Información del Producto</div>

                <div class="field-row">
                    <asp:Label runat="server" AssociatedControlID="ddlProducto"
                        CssClass="field-label required" Text="Producto:" />
                    <asp:DropDownList ID="ddlProducto" runat="server"
                        CssClass="form-control"
                        AutoPostBack="true"
                        OnSelectedIndexChanged="ddlProducto_SelectedIndexChanged" />
                    <asp:RequiredFieldValidator
                        ControlToValidate="ddlProducto"
                        InitialValue=""
                        ErrorMessage="Seleccione un producto"
                        CssClass="error-message"
                        runat="server" />
                </div>

                <div class="field-row">
                    <asp:Label runat="server" AssociatedControlID="txtMonto"
                        CssClass="field-label required" Text="Monto:" />
                    <asp:TextBox ID="txtMonto" runat="server"
                        CssClass="form-control"
                        placeholder="Ingrese el monto (solo números)"
                        onkeypress="return soloNumeros(event)" />
                </div>
                <asp:RequiredFieldValidator
                    ControlToValidate="txtMonto"
                    ErrorMessage="El monto es obligatorio"
                    CssClass="error-message"
                    runat="server" />
                <asp:RegularExpressionValidator
                    ControlToValidate="txtMonto"
                    ValidationExpression="^[0-9]+(\.[0-9]{1,2})?$"
                    ErrorMessage="Monto inválido"
                    CssClass="error-message"
                    runat="server" />

                <div class="field-row">
                    <asp:Label runat="server" CssClass="field-label required" Text="Plazo:" />
                    <asp:TextBox ID="txtPlazo" runat="server"
                        CssClass="form-control readonly-field"
                        ReadOnly="true"
                        placeholder="Sin plazo seleccionado" />
                    <asp:Button ID="btnSeleccionarPlazo" runat="server"
                        Text="Seleccionar plazo"
                        CssClass="btn btn-primary"
                        OnClick="btnSeleccionarPlazo_Click" />
                    <asp:RequiredFieldValidator
                        ControlToValidate="txtPlazo"
                        ErrorMessage="Debe seleccionar un plazo"
                        CssClass="error-message"
                        runat="server" />
                </div>

                <div class="field-row">
                    <asp:Label runat="server" AssociatedControlID="txtTasa"
                        CssClass="field-label" Text="Tasa:" />
                    <asp:TextBox ID="txtTasa" runat="server"
                        CssClass="form-control readonly-field"
                        Enabled="false"
                        placeholder="Se llena al seleccionar producto" />
                </div>

                <div class="field-row">
                    <asp:Label runat="server" AssociatedControlID="ddlImpuesto"
                        CssClass="field-label required" Text="Impuesto:" />
                    <asp:DropDownList ID="ddlImpuesto" runat="server" CssClass="form-control" />
                    <asp:RequiredFieldValidator
                        ControlToValidate="ddlImpuesto"
                        InitialValue=""
                        ErrorMessage="Seleccione un impuesto"
                        CssClass="error-message"
                        runat="server" />
                </div>
            </div>

            <hr class="form-divider" />

            <!-- ═══ SECCIÓN 3 · RESULTADOS ═══ -->
            <div class="results-section">
                <div class="section-title">Resultados del Cálculo</div>

                <div class="result-row">
                    <asp:Label runat="server" AssociatedControlID="txtInteresBruto"
                        CssClass="field-label" Text="Monto Total Interés Bruto:" />
                    <asp:TextBox ID="txtInteresBruto" runat="server"
                        CssClass="form-control result-value readonly-field"
                        ReadOnly="true" Text="0.00" />
                </div>

                <div class="result-row">
                    <asp:Label runat="server" AssociatedControlID="txtTotalImpuesto"
                        CssClass="field-label" Text="Monto Total Impuesto:" />
                    <asp:TextBox ID="txtTotalImpuesto" runat="server"
                        CssClass="form-control result-value readonly-field"
                        ReadOnly="true" Text="0.00" />
                </div>

                <div class="result-row">
                    <asp:Label runat="server" AssociatedControlID="txtTotalNeto"
                        CssClass="field-label" Text="Monto Total Neto:" />
                    <asp:TextBox ID="txtTotalNeto" runat="server"
                        CssClass="form-control result-value net-total readonly-field"
                        ReadOnly="true" Text="0.00" />
                </div>
            </div>

            <!-- ═══ BOTONES ═══ -->
            <div class="btn-row">
                <asp:Button ID="btnCalcular" runat="server" Text="Calcular"
                    CssClass="btn btn-primary"
                    OnClick="btnCalcular_Click" />
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar"
                    CssClass="btn btn-secondary"
                    OnClick="btnGuardar_Click" />
                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar"
                    CssClass="btn btn-danger"
                    OnClick="btnCancelar_Click"
                    CausesValidation="false" />
            </div>

        </div><!-- /form-body -->

    </div><!-- /form-card -->

    <uc:SelectorPlazosForm ID="ModalPlazos" runat="server"
        OnPlazoSeleccionado="ModalPlazos_PlazoSeleccionado" />

</asp:Content>