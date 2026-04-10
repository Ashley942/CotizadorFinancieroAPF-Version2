function abrirModalPlazo() {
    document.getElementById("modalPlazo").style.display = "flex";
}

function seleccionarPlazo(idPlazo, valor, unidad) {
    var config = document.getElementById("selectorPlazosConfig");
    var hfId = config.getAttribute("data-hf-id");
    var hfTextoId = config.getAttribute("data-hf-texto-id"); 
    var uniqueId = config.getAttribute("data-uniqueid");

    // 1. Guarda el ID
    document.getElementById(hfId).value = idPlazo;

    // 2.Guarda el texto en el HiddenField
    document.getElementById(hfTextoId).value = valor + " " + unidad;

    // 3. Cierra el modal
    document.getElementById("modalPlazo").style.display = "none";

    // 4. PostBack
    __doPostBack(uniqueId, "PlazoSeleccionado");
}

function cerrarModalPlazo(event) {
    const modal = document.getElementById("modalPlazo");

    // cerrar SOLO si el click fue en el fondo
    if (event.target.classList.contains("modal-overlay")) {
        modal.style.display = "none";
    }
}
