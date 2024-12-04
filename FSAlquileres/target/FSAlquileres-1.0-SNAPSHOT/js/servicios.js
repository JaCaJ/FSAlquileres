$(document).ready(function () {
    $("#mensaje").hide();
    listadoserviciosajax();
});
function abrirReporte(idSer) {
    window.open('jsp/reporte_servicio.jsp?idRep=' + idSer, '_blank');
}
$("#cancelar").on('click', function () {
    $("#form")[0].reset();
    $("#listar").val("cargar");
});
function listadoserviciosajax() {
    $.ajax({
        data: {listar: "listar"},
        url: 'jsp/servicios.jsp',
        type: 'post',
        success: function (response) {
            $("#resultado tbody").html(response);
        }
    });
}
function rellenar(id, ser_descripcion, ser_precio, ser_existencia) {
    $("#listar").val("modificar");
    $("#pk").val(id);
    $("#ser_descripcion").val(ser_descripcion);
    $("#ser_precio").val(ser_precio);
    $("#ser_existencia").val(ser_existencia);
    $("#ser_descripcion").focus();
}
$("#boton").on('click', function () {
    if ($("#ser_descripcion").val() === "") {
        alert('Debe ingresar una descripción.');
        $("#ser_descripcion").focus();
        return false;
    }
    if ($("#ser_precio").val() === "") {
        alert('Debe ingresar un precio.');
        $("#ser_precio").focus();
        return false;
    }
    if ($("#ser_existencia").val() === "") {
        alert('Debe ingresar una cantidad para la existencia.');
        $("#ser_existencia").focus();
        return false;
    }

    datosformulario = $("#form").serialize();
    $.ajax({
        data: datosformulario,
        url: 'jsp/servicios.jsp',
        type: 'post',
        success: function (response) {
            $("#mensaje").show();
            $("#mensaje").focus();
            if (response == 0) {
                $("#mensaje").html("Ya existe servicio, no puede ingresar dato duplicado");
            }
            if (response == 1) {
                $("#mensaje").html("Insertado correctamente...");
            }
            if (response == 2) {
                $("#mensaje").html("Modificado correctamente...");
            }
            $("#mensaje").fadeOut(4000, function () {
                $("#mensaje").html("");
            });
            if (response != 0) {
                $("#listar").val("cargar");
                $("#pk").val("");
                $("#ser_descripcion").val("");
                $("#ser_precio").val("");
                $("#ser_existencia").val("");
            }
            $("#ser_descripcion").focus();
            listadoserviciosajax();
        }
    });
});
$("#eliminarreg").on('click', function () {
    pkdel = $("#pkdel").val();
    $.ajax({
        data: {listar: 'eliminar', pkdel: pkdel},
        url: 'jsp/servicios.jsp',
        type: 'post',
        success: function (response) {
            listadoserviciosajax();
            $("#modalDark").modal("hide");
            //$("#exampleModal data-dismiss").click();
            $("#mensaje").show();
            if (response == 3) {
                $("#mensaje").html("Eliminado correctamente...");
            }
            $("#mensaje").fadeOut(4000, function () {
                $("#mensaje").html("");
            });
            if (response != 0) {
                $("#listar").val("cargar");
                $("#pk").val("");
                $("#ser_descripcion").val("");
                $("#ser_precio").val("");
                $("#ser_existencia").val("");
            }
            $("#ser_descripcion").focus();
        }
    });
});
