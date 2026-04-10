<%@ Page Title="" Language="C#" MasterPageFile="~/Vistas/PaginaMaestra.Master" AutoEventWireup="true" CodeBehind="Impuestos.aspx.cs" Inherits="CotizadorFinancieroAPF.Vistas.Impuestos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<div class="container mt-4">

    <div class="card shadow">

        <div class="card-header bg-success text-white d-flex justify-content-between">
            <h4 class="mb-0">💰 Gestión de Impuestos</h4>

            <asp:Button ID="btnNuevo" runat="server"
                Text=" Nuevo Impuesto"
                CssClass="btn btn-light"
                OnClick="btnNuevo_Click" />
        </div>

        <div class="card-body">

            <asp:Label ID="lblMensaje" runat="server" CssClass="text-danger"></asp:Label>

            <asp:GridView ID="gvImpuestos" runat="server"
                AutoGenerateColumns="false"
                CssClass="table table-hover"
                DataKeyNames="id_impuesto"
                OnRowCommand="gvImpuestos_RowCommand">

                <Columns>

                    <asp:BoundField DataField="id_impuesto" HeaderText="#" />

                    <asp:BoundField DataField="Impuesto" HeaderText="Impuesto (%)" />

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
                                CommandArgument='<%# Eval("id_impuesto") %>'
                                CssClass="btn btn-warning btn-sm me-1">
                                ✏️
                            </asp:LinkButton>

                            <asp:LinkButton runat="server"
                                CommandName="Estado"
                                CommandArgument='<%# Eval("id_impuesto") %>'
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
<div class="modal fade" id="modalImpuesto">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header bg-success text-white">
                <h5>Impuesto</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">

                <asp:HiddenField ID="hfIdImpuesto" runat="server" />

                <label>Valor (%)</label>
                <asp:TextBox ID="txtImpuesto" runat="server" CssClass="form-control"></asp:TextBox>

            </div>

            <div class="modal-footer">
                <asp:Button ID="btnGuardar" runat="server"
                    Text="Guardar"
                    CssClass="btn btn-success"
                    OnClick="btnGuardar_Click" />
            </div>

        </div>
    </div>
</div>

<script>
    function mostrarModalImpuesto() {
        new bootstrap.Modal(document.getElementById('modalImpuesto')).show();
    }
</script>

</asp:Content>