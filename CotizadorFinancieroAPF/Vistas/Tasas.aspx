<%@ Page Title="" Language="C#" MasterPageFile="~/Vistas/PaginaMaestra.Master" AutoEventWireup="true" CodeBehind="Tasas.aspx.cs" Inherits="CotizadorFinancieroAPF.Vistas.Tasas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<div class="container mt-4">

    <div class="card shadow">

        <div class="card-header bg-primary text-white d-flex justify-content-between">
            <h4 class="mb-0">📊 Gestión de Tasas</h4>

            <asp:Button ID="btnNuevo" runat="server"
                Text=" Nueva Tasa"
                CssClass="btn btn-light"
                OnClick="btnNuevo_Click" />
        </div>

        <div class="card-body">

            <asp:Label ID="lblMensaje" runat="server" CssClass="text-danger"></asp:Label>

            <asp:GridView ID="gvTasas" runat="server"
                AutoGenerateColumns="false"
                CssClass="table table-hover"
                DataKeyNames="id_tasa"
                OnRowCommand="gvTasas_RowCommand">

                <Columns>

                    <asp:BoundField DataField="id_tasa" HeaderText="#" />

                    <asp:BoundField DataField="nombre_producto" HeaderText="Producto" />

                
                    <asp:TemplateField HeaderText="Plazo">
                        <ItemTemplate>
                            <%# Eval("plazo") + " " + (Eval("unidad").ToString() == "M" ? "Meses" : "Días") %>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="tasa" HeaderText="Tasa (%)" DataFormatString="{0:N2}" />

                    <asp:TemplateField HeaderText="Estado">
                        <ItemTemplate>
                            <span class='badge <%# Convert.ToBoolean(Eval("estado")) ? "bg-success" : "bg-danger" %>'>
                                <%# Convert.ToBoolean(Eval("estado")) ? "Activo" : "Inactivo" %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Acciones">
                        <ItemTemplate>

                            <asp:LinkButton runat="server"
                                CommandName="Editar"
                                CommandArgument='<%# Eval("id_tasa") %>'
                                CssClass="btn btn-warning btn-sm me-1">
                                ✏️
                            </asp:LinkButton>

                            <asp:LinkButton runat="server"
                                CommandName="Estado"
                                CommandArgument='<%# Eval("id_tasa") %>'
                                CssClass="btn btn-outline-danger btn-sm"
                                OnClientClick="return confirm('¿Cambiar estado?');">
                                🔒
                            </asp:LinkButton>

                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>

        </div>
    </div>
</div>

<!-- MODAL -->
<div class="modal fade" id="modalTasa">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header bg-primary text-white">
                <h5>Tasa</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">

                <asp:HiddenField ID="hfIdTasa" runat="server" />

                <label>Producto</label>
                <asp:DropDownList ID="ddlProducto" runat="server" CssClass="form-control"></asp:DropDownList>

                <label class="mt-2">Plazo</label>
                <asp:DropDownList ID="ddlPlazo" runat="server" CssClass="form-control"></asp:DropDownList>

                <label class="mt-2">Tasa (%)</label>
                <asp:TextBox ID="txtTasa" runat="server" CssClass="form-control"></asp:TextBox>

            </div>

            <div class="modal-footer">
                <asp:Button ID="btnGuardar" runat="server"
                    Text="Guardar"
                    CssClass="btn btn-primary"
                    OnClick="btnGuardar_Click" />
            </div>

        </div>
    </div>
</div>

<script>
    function mostrarModal() {
        new bootstrap.Modal(document.getElementById('modalTasa')).show();
    }
</script>

</asp:Content>