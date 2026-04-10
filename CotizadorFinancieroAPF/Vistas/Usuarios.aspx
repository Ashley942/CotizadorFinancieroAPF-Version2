<%@ Page Title="" Language="C#" MasterPageFile="~/Vistas/PaginaMaestra.master" AutoEventWireup="true" CodeBehind="Usuarios.aspx.cs" Inherits="CotizadorFinancieroAPF.Vistas.Usuarios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Gestión de Usuarios</h2>

    <!-- Mensajes -->
    <asp:Label ID="lblMensaje" runat="server" ForeColor="Red"></asp:Label>

    <br /><br />

    <asp:GridView ID="gvUsuarios" runat="server" AutoGenerateColumns="false"
        DataKeyNames="IdUsuario"
        CssClass="table"
        OnRowEditing="gvUsuarios_RowEditing"
        OnRowCancelingEdit="gvUsuarios_RowCancelingEdit"
        OnRowUpdating="gvUsuarios_RowUpdating">

        <Columns>

            <%-- ID --%>
            <asp:BoundField DataField="IdUsuario" HeaderText="ID" ReadOnly="true" />

            <%-- Nombre --%>
            <asp:BoundField DataField="Nombre" HeaderText="Nombre" />

            <%-- Rol --%>
            <asp:TemplateField HeaderText="Rol">
                <ItemTemplate>
                    <%# Eval("Rol") %>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlRoles" runat="server"></asp:DropDownList>
                </EditItemTemplate>
            </asp:TemplateField>

            <%-- Nueva contraseña --%>
            <asp:TemplateField HeaderText="Nueva Contraseña">
                <ItemTemplate>
                    ****
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>

           
            <asp:CommandField ShowEditButton="true" />

        </Columns>
    </asp:GridView>

</asp:Content>