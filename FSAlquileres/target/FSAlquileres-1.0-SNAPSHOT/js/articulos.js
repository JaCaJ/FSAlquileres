$(document).ready(function () {
    $("#mensaje").hide();
    listadoarticulosajax();
    rellenarTa();
});
function rellenarTa() {
    $.ajax({
        data: {listar: 'buscarTa'},
        url: 'jsp/articulos.jsp',
        type: 'post',
        success: function (response) {
            $("#selectTa").html(response);
        }
    });
}
$("#cancelar").on('click', function () {
    $("#form")[0].reset();
    $("#listar").val("cargar");
});
function dividirTa(a) {
    datosp = a.split(',');
    $("#fk").val(datosp[0]);
}
function abrirReporte(idArt) {
    window.open('jsp/reporte_articulo.jsp?idRep=' + idArt, '_blank');
}
function listadoarticulosajax() {
    $.ajax({
        data: {listar: "listar"},
        url: 'jsp/articulos.jsp',
        type: 'post',
        success: function (response) {
            $("#resultado tbody").html(response);
        }
    });
}
function rellenar(id, art_nombre, art_precio, art_estado, art_existencia, fk, articulo_tipo_descripcion) {
    $("#listar").val("modificar");
    $("#pk").val(id);
    $("#art_nombre").val(art_nombre);
    $("#art_precio").val(art_precio);
    $("#art_estado").val(art_estado);
    $("#art_existencia").val(art_existencia);
    $("#fk").val(fk);
    $("#selectTa").val(fk+","+articulo_tipo_descripcion);
    
    $("#art_nombre").focus();
}
$("#boton").on('click', function () {
    if ($("#art_nombre").val() === "") {
        alert('Debe ingresar un nombre.');
        $("#art_nombre").focus();
        return false;
    }
    if ($("#art_precio").val() === "") {
        alert('Debe ingresar el precio.');
        $("#art_precio").focus();
        return false;
    }
    if ($("#art_estado").val() === "0") {
        alert('Debe seleccionar un estado .');
        $("#art_estado").focus();
        return false;
    }
    if ($("#art_existencia").val() === "") {
        alert('Debe ingresar una existencia.');
        $("#art_existencia").focus();
        return false;
    }

    if ($("#fk").val() === "") {
        alert('Debe ingresar un tipo de articulo.');
        $("#fk").focus();
        return false;
    }

    datosformulario = $("#form").serialize();
    $.ajax({
        data: datosformulario,
        url: 'jsp/articulos.jsp',
        type: 'post',
        success: function (response) {
            $("#mensaje").show();
            $("#mensaje").focus();
            if (response == 0) {
                $("#mensaje").html("Ya existe articulo, no puede ingresar dato duplicado");
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
                $("#art_nombre").val("");
                $("#art_precio").val("");
                $("#art_estado").val("0");
                $("#art_existencia").val("");
                $("#fk").val("");
                $("#selectPersonal").val("").prop('selectedIndex', 0);
                $("#selectTa").val("").prop('selectedIndex', 0);
            }
            $("#art_nombre").focus();
            listadoarticulosajax();
        }
    });
});
$("#eliminarreg").on('click', function () {
    pkdel = $("#pkdel").val();
    $.ajax({
        data: {listar: 'eliminar', pkdel: pkdel},
        url: 'jsp/articulos.jsp',
        type: 'post',
        success: function (response) {
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
                $("#art_nombre").val("");
                $("#art_precio").val("");
                $("#art_estado").val("0");
                $("#art_existencia").val("");
                $("#fk").val("");
            }
            $("#art_nombre").focus();
            listadoarticulosajax();
        }
    });
});
