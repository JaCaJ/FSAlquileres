$(document).ready(function () {
    $("#mensaje").hide();
    listadoclientesajax();
});
$("#cancelar").on('click', function () {
    $("#form")[0].reset();
    $("#listar").val("cargar");
});
function abrirReporte(idClie) {
    window.open('jsp/reporte_cliente.jsp?idRep=' + idClie, '_blank');
}
function listadoclientesajax() {
    $.ajax({
        data: {listar: "listar"},
        url: 'jsp/clientes.jsp',
        type: 'post',
        success: function (response) {
            $("#resultado tbody").html(response);
        }
    });
}
function rellenar(id, cli_nombre, cli_apellido, cli_ci, cli_telefono, cli_direccion_maps, cli_referencia_direccion) {
    $("#listar").val("modificar");
    $("#pk").val(id);
    $("#cli_nombre").val(cli_nombre);
    $("#cli_apellido").val(cli_apellido);
    $("#cli_ci").val(cli_ci);
    $("#cli_telefono").val(cli_telefono);
    $("#cli_direccion_maps").val(cli_direccion_maps);
    $("#cli_referencia_direccion").val(cli_referencia_direccion);
    $("#cli_nombre").focus();
}
$("#boton").on('click', function () {
    if ($("#cli_nombre").val() === "") {
        alert('Debe ingresar un nombre.');
        $("#cli_nombre").focus();
        return false;
    }
    if ($("#cli_ci").val() === "") {
        alert('Debe ingresar CI.');
        $("#cli_ci").focus();
        return false;
    }
    if ($("#cli_telefono").val() === "") {
        alert('Debe ingresar un teléfono.');
        $("#cli_telefono").focus();
        return false;
    }

    datosformulario = $("#form").serialize();
    $.ajax({
        data: datosformulario,
        url: 'jsp/clientes.jsp',
        type: 'post',
        success: function (response) {
            $("#mensaje").show();
            $("#mensaje").focus();
            if (response == 0) {
                $("#mensaje").html("Ya existe el cliente, no puede ingresar un dato duplicado.");
            }
            if (response == 1) {
                $("#mensaje").html("Guardado correctamente...");
            }
            if (response == 2) {
                $("#mensaje").html("Modificado correctamente...");
            }
            if (response != 0) {
                $("#listar").val("cargar");
                $("#pk").val("");
                $("#cli_ci").val("");
                $("#cli_nombre").val("");
                $("#cli_apellido").val("");
                $("#cli_telefono").val("");
                $("#cli_direccion_maps").val("");
                $("#cli_referencia_direccion").val("");
            }
            $("#cli_nombre").focus();
            $("#mensaje").hide(5000, function () {
                $("#mensaje").html("");
            });
            listadoclientesajax();
        }
    });
});
$("#eliminarreg").on('click', function () {
    pkdel = $("#pkdel").val();
    $.ajax({
        data: {listar: 'eliminar', pkdel: pkdel},
        url: 'jsp/clientes.jsp',
        type: 'post',
        success: function (response) {
            listadoclientesajax();
            $("#modalDark").modal("hide");
            if (response == 3) {
                $("#mensaje").show();
                $("#mensaje").focus();
                $("#mensaje").html("Eliminado correctamente...");
            }
            if (response != 0) {
                $("#listar").val("cargar");
                $("#pk").val("");
                $("#cli_ci").val("");
                $("#cli_nombre").val("");
                $("#cli_apellido").val("");
                $("#cli_telefono").val("");
                $("#cli_direccion_maps").val("");
                $("#cli_referencia_direccion").val("");
            }
            $("#mensaje").fadeOut(4000, function () {
                $("#mensaje").html("");
            });
        }
    });
});
