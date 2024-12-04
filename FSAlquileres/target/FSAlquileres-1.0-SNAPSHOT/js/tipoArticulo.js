$(document).ready(function () {
    listadotipoarticuloajax();
    $("#mensaje").hide();
});
function abrirReporte(idTa) {
    window.open('jsp/reporte_tipoArticulo.jsp?idRep=' + idTa, '_blank');
}
$("#cancelar").on('click', function () {
    $("#form")[0].reset();
    $("#listar").val("cargar");
});
function listadotipoarticuloajax() {
    $.ajax({
        data: {listar: "listar"},
        url: 'jsp/tipoArticulo.jsp',
        type: 'post',
        success: function (response) {
            $("#resultado tbody").html(response);
        }
    });
}
function rellenar(id, tipoArt) {
    $("#listar").val("modificar");
    $("#tipoArt").val(tipoArt);
    $("#pk").val(id);
    $("#tipoArt").focus();
}
$("#boton").on('click', function () {
    if ($("#tipoArt").val() === "") {
        alert('No puede ingresar un dato vacío.');
        $("#tipoArt").focus();
        return false;
    }
    datosformulario = $("#form").serialize();
    $.ajax({
        data: datosformulario,
        url: 'jsp/tipoArticulo.jsp',
        type: 'post',
        success: function (response) {
            $("#mensaje").show();
            $("#mensaje").focus();
            if (response == 0) {
                $("#mensaje").html("Ya existe tipo de articulo, no puede ingresar dato duplicado");
            }
            if (response == 1) {
                $("#mensaje").html("Insertado correctamente...");
            }
            if (response == 2) {
                $("#mensaje").html("Modificado correctamente...");
            }
            $("#mensaje").fadeOut(4000, function () {
                $("#mensaje").html("");
                $("#tipoArt").focus();
            });
            if (response != 0) {
                $("#listar").val("cargar");
                $("#pk").val("");
                $("#tipoArt").val("");
            }

            listadotipoarticuloajax();
        }
    });
});
$("#eliminarreg").on('click', function () {
    pkdel = $("#pkdel").val();
    $.ajax({
        data: {listar: 'eliminar', pkdel: pkdel},
        url: 'jsp/tipoArticulo.jsp',
        type: 'post',
        success: function (response) {
            listadotipoarticuloajax();
            $("#modalDark").modal("hide");
            //$("#exampleModal data-dismiss").click();
            $("#mensaje").show();
            if (response == 3) {
                $("#mensaje").html("Eliminado correctamente...");
            }
            $("#mensaje").fadeOut(4000, function () {
                $("#mensaje").html("");
                $("#tipoArt").focus();
            });
            if (response != 0) {
                $("#listar").val("cargar");
                $("#pk").val("");
                $("#tipoArt").val("");
            }
        }
    });
});


