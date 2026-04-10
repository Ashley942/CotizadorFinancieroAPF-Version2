<%@ Control Language="C#" AutoEventWireup="true"
    CodeBehind="SelectorPlazosForm.ascx.cs"
    Inherits="CotizadorFinancieroAPF.Vistas.SelectorPlazosForm" %>

<link href="../Estilos/SelectorPlazosEstilos.css" rel="stylesheet" />

<!-- Overlay: clic fuera cierra el modal -->
<div id="modalPlazo" class="modal-overlay" style="display: none;" onclick="cerrarModalPlazo(event)">

    <div class="modal-contenido" onclick="event.stopPropagation()">

        <h3>Seleccione un plazo</h3>

        <div class="grid-plazos">
            <asp:Repeater ID="rptPlazos" runat="server">
                <ItemTemplate>
                    <div class="card-plazo"
                        onclick="seleccionarPlazo('<%# Eval("idplazo") %>', '<%# Eval("plazo") %>', '<%# Eval("unidadplazo") %>')">
                        <%# Eval("plazo") %> <%# Eval("unidadplazo") %>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

    </div>

</div>

<!-- Campo oculto que guarda el plazo seleccionado para el servidor -->
<asp:HiddenField ID="hfPlazoSeleccionado" runat="server" />
<asp:HiddenField ID="hfTextoPlazo"        runat="server" /> 

<!-- Puente: expone el ClientID al JS externo -->

<div id="selectorPlazosConfig"
     data-hf-id="<%= hfPlazoSeleccionado.ClientID %>"
      data-hf-texto-id="<%= hfTextoPlazo.ClientID %>" 
     data-uniqueid="<%= UniqueID %>">        
</div>


<!-- Script externo para manejar la lógica del modal y la selección de plazos -->
<script src="../Scripts/SelectorPlazos.js"></script>
