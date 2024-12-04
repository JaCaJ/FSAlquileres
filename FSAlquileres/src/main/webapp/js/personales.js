$(document).ready(function () {
    $("#mensaje").hide();
    listadopersonalesajax();
});
function abrirReporte(idPer) {
    window.open('jsp/reporte_personal.jsp?idRep=' + idPer, '_blank');
}
$("#cancelar").on('click', function () {
    $("#form")[0].reset();
    $("#listar").val("cargar");
});
function listadopersonalesajax() {
    $.ajax({
        data: {listar: "listar"},
        url: 'jsp/personales.jsp',
        type: 'post',
        success: function (response) {
            $("#resultado tbody").html(response);
        }
    });
}
function rellenar(id, per_nombre, per_apellido, per_ci, per_telefono) {
    $("#listar").val("modificar");
    $("#pk").val(id);
    $("#per_nombre").val(per_nombre);
    $("#per_apellido").val(per_apellido);
    $("#per_ci").val(per_ci);
    $("#per_telefono").val(per_telefono);
    $("#per_nombre").focus();
}
$("#boton").on('click', function () {
    if ($("#per_nombre").val() === "") {
        alert('Debe ingresar un nombre.');
        $("#per_nombre").focus();
        return false;
    }
    if ($("#per_apellido").val() === "") {
        alert('Debe ingresar un apellido.');
        $("#per_apellido").focus();
        return false;
    }
    if ($("#per_ci").val() === "") {
        alert('Debe ingresar un ci.');
        $("#per_ci").focus();
        return false;
    }
    if ($("#per_telefono").val() === "") {
        alert('Debe ingresar un teléfono.');
        $("#per_telefono").focus();
        return false;
    }
    datosformulario = $("#form").serialize();
    $.ajax({
        data: datosformulario,
        url: 'jsp/personales.jsp',
        type: 'post',
        success: function (response) {
            $("#mensaje").show();
            $("#mensaje").focus();
            if (response == 0) {
                $("#mensaje").html("Ya existe el personal, no puede ingresar dato duplicado");
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
                $("#per_ci").val("");
                $("#per_nombre").val("");
                $("#per_apellido").val("");
                $("#per_telefono").val("");
            }
            $("#per_nombre").focus();
            listadopersonalesajax();
        }
    });
});
$("#eliminarreg").on('click', function () {
    pkdel = $("#pkdel").val();
    $.ajax({
        data: {listar: 'eliminar', pkdel: pkdel},
        url: 'jsp/personales.jsp',
        type: 'post',
        success: function (response) {
            listadopersonalesajax();
            $("#modalDark").modal("hide");
            //$("#exampleModal data-dismiss").click();
            $("#mensaje").show();
            $("#mensaje").focus();
            if (response == 3) {
                $("#mensaje").html("Eliminado correctamente...");
            }
            $("#mensaje").fadeOut(4000, function () {
                $("#mensaje").html("");
            });
            $("#per_nombre").focus();
            if (response != "0") {
                $("#listar").val("cargar");
                $("#pk").val("");
                $("#per_ci").val("");
                $("#per_nombre").val("");
                $("#per_apellido").val("");
                $("#per_telefono").val("");
            }
        }
    });
});
