<%@ Page Title="" Language="C#" MasterPageFile="~/Vistas/PaginaMaestra.master" AutoEventWireup="true" CodeBehind="Productos.aspx.cs" Inherits="CotizadorFinancieroAPF.Vistas.Productos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


<div class="container mt-4">

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3>📦 Gestión de Productos</h3>

        <asp:Button ID="btnNuevo" runat="server"
            Text=" Nuevo"
            CssClass="btn btn-success"
            OnClick="btnNuevo_Click" />
    </div>

    <asp:Label ID="lblMensaje" runat="server" CssClass="text-danger"></asp:Label>

    <!-- GRID -->
    <asp:GridView ID="gvProductos" runat="server"
        AutoGenerateColumns="false"
        CssClass="table table-hover shadow-sm"
        DataKeyNames="id_producto"
        OnRowCommand="gvProductos_RowCommand">

        <Columns>

            <asp:BoundField DataField="id_producto" HeaderText="#" />

            <asp:BoundField DataField="nombre_producto" HeaderText="Producto" />

            <asp:BoundField DataField="moneda" HeaderText="Moneda" />

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
                        CommandArgument='<%# Eval("id_producto") %>'
                        CssClass="btn btn-warning btn-sm me-1">
                        <i class="fa fa-edit"></i>
                    </asp:LinkButton>

                    <asp:LinkButton runat="server"
                        CommandName="Estado"
                        CommandArgument='<%# Eval("id_producto") %>'
                        OnClientClick="return confirmarCambio();"
                        CssClass="btn btn-danger btn-sm">
                        <i class="fa fa-ban"></i>
                    </asp:LinkButton>

                </ItemTemplate>
            </asp:TemplateField>

        </Columns>
    </asp:GridView>

</div>

<!-- MODAL -->
<div class="modal fade" id="modalProducto" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title">Producto</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">

                <asp:HiddenField ID="hfIdProducto" runat="server" />

                <label>Nombre</label>
                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" />

                
                <label>Moneda</label>
                <asp:DropDownList ID="ddlMoneda" runat="server" CssClass="form-control"></asp:DropDownList>

            </div>

            <div class="modal-footer">
                <asp:Button ID="btnGuardar" runat="server"
                    Text="Guardar"
                    CssClass="btn btn-primary"
                    OnClick="btnGuardar_Click" />

                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    Cancelar
                </button>
            </div>

        </div>
    </div>
</div>

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function mostrarModal() {
        var modal = new bootstrap.Modal(document.getElementById('modalProducto'));
        modal.show();
    }

    function confirmarCambio() {
        return confirm("¿Desea cambiar el estado del producto?");
    }
</script>

</asp:Content>
