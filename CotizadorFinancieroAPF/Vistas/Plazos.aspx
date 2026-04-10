<%@ Page Title="" Language="C#" MasterPageFile="~/Vistas/PaginaMaestra.Master" AutoEventWireup="true" CodeBehind="Plazos.aspx.cs" Inherits="CotizadorFinancieroAPF.Vistas.Plazos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<div class="container mt-4">

    <div class="card shadow">

        <div class="card-header bg-dark text-white d-flex justify-content-between">
            <h4 class="mb-0">📅 Gestión de Plazos</h4>

            <asp:Button ID="btnNuevo" runat="server"
                Text="+ Nuevo Plazo"
                CssClass="btn btn-light"
                OnClick="btnNuevo_Click" />
        </div>

        <div class="card-body">

            <asp:Label ID="lblMensaje" runat="server" CssClass="text-danger"></asp:Label>

            <asp:GridView ID="gvPlazos" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered table-hover align-middle text-center" DataKeyNames="IdPlazo,Plazo,UnidadPlazo"
                   OnRowCommand="gvPlazos_RowCommand">

                   <Columns>

                       <asp:BoundField DataField="IdPlazo" HeaderText="#" />

                      
                       <asp:TemplateField HeaderText="Plazo">
                           <ItemTemplate>
                               <span class="fw-semibold">
                                   <%# Eval("Plazo") %> 
                                   <%# Eval("UnidadPlazo").ToString() == "D" ? "días" : "meses" %>
                               </span>
                           </ItemTemplate>
                       </asp:TemplateField>

                      
                       <asp:TemplateField HeaderText="Estado">
                           <ItemTemplate>
                               <span class='badge <%# Convert.ToBoolean(Eval("Estado")) ? "bg-success" : "bg-danger" %>'>
                                   <%# Convert.ToBoolean(Eval("Estado")) ? "Activo" : "Inactivo" %>
                               </span>
                           </ItemTemplate>
                       </asp:TemplateField>

                      
                       <asp:TemplateField HeaderText="Acciones">
                           <ItemTemplate>

                            
                               <asp:LinkButton runat="server"
                                   CommandName="Editar"
                                   CommandArgument='<%# Container.DataItemIndex %>'
                                   CssClass="btn btn-warning btn-sm me-1">
                                   ✏️
                               </asp:LinkButton>

                            
                               <asp:LinkButton runat="server"
                                   CommandName="Estado"
                                   CommandArgument='<%# Eval("IdPlazo") %>'
                                   CssClass="btn btn-outline-dark btn-sm"
                                   OnClientClick="return confirm('¿Cambiar estado?');">

                                   <%# Convert.ToBoolean(Eval("Estado")) ? "🔒" : "🔓" %>

                               </asp:LinkButton>

                           </ItemTemplate>
                       </asp:TemplateField>

                   </Columns>
            </asp:GridView>
        </div>
    </div>
</div>


<div class="modal fade" id="modalPlazo">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header bg-dark text-white">
                <h5>Plazo</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">

                <asp:HiddenField ID="hfIdPlazo" runat="server" />

                <label>Cantidad</label>
                <asp:TextBox ID="txtPlazo" runat="server" CssClass="form-control"></asp:TextBox>

                <label class="mt-2">Unidad</label>
                <asp:DropDownList ID="ddlUnidad" runat="server" CssClass="form-control">
                    <asp:ListItem Text="Días" Value="D"></asp:ListItem>
                    <asp:ListItem Text="Meses" Value="M"></asp:ListItem>
                </asp:DropDownList>

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
        new bootstrap.Modal(document.getElementById('modalPlazo')).show();
    }
</script>

</asp:Content>
