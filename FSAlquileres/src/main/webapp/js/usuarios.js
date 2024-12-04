$(document).ready(function () {
    $("#mensaje").hide();
    listadousuariosajax();
    rellenarpersonal();
});
function abrirReporte(idUsu) {
    window.open('jsp/reporte_usuario.jsp?idRep=' + idUsu, '_blank');
}
function listadousuariosajax() {
    $.ajax({
        data: {listar: "listar"},
        url: 'jsp/usuarios.jsp',
        type: 'post',
        success: function (response) {
            $("#resultado tbody").html(response);
        }
    });
}
function rellenar(id, usu_nick, usu_rol, fk, per_nombre) {
    $("#listar").val("modificar");
    $("#pk").val(id);
    $("#usu_nick").val(usu_nick);
    $("#usu_rol").val(usu_rol);
    $("#fk").val(fk);
    $("#selectPersonal").val(fk + "," + per_nombre);

    $("#usu_clave").prop("disabled", true);
    $("#usu_clave").prop("title", "Para cambiar la contraseña vaya a la sección cambiar contraseña.");
    $("#usu_clave").prop("placeholder", "Para cambiar la contraseña vaya a la sección cambiar contraseña.");
    $("#usu_nick").focus();
}
$("#boton").on('click', function () {
    if ($("#usu_nick").val() === "") {
        alert('Debe ingresar un nick.');
        $("#usu_nick").focus();
        return false;
    }
    if ($("#listar").val() !== "modificar") {
        if ($("#usu_clave").val() === "") {
            alert('Debe ingresar una clave.');
            $("#usu_clave").focus();
            return false;
        }
    }
    if ($("#usu_rol").val() === "0") {
        alert('Debe seleccionar un rol.');
        $("#usu_rol").focus();
        return false;
    }
    if ($("#usu_per_id_fk").val() === "") {
        alert('Debe ingresar un usuario.');
        $("#usu_per_id_fk").focus();
        return false;
    }
    if ($("#selectPersonal").val() === "0") {
        alert('Debe seleccionar un personal');
        $("#selectPersonal").focus();
        return false;
    }

    datosformulario = $("#form").serialize();
    $.ajax({
        data: datosformulario,
        url: 'jsp/usuarios.jsp',
        type: 'post',
        success: function (response) {
            $("#mensaje").show();
            $("#mensaje").focus();
            if (response == 0) {
                $("#mensaje").html("Ya existe usuario, no puede ingresar dato duplicado");
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
                $("#usu_nick").val("");
                $("#usu_clave").val("");

                $("#usu_rol").val("0");
                $("#fk").val("");
                $("#selectPersonal").val("").prop('selectedIndex', 0);
                $("#usu_clave").prop("disabled", false);
                $("#usu_clave").prop("title", "Ingrese clave para usuario");
                $("#usu_clave").prop("placeholder", "Ingrese clave para usuario");
            }
            $("#usu_nick").focus();
            listadousuariosajax();
        }
    });
});
$("#eliminarreg").on('click', function () {
    pkdel = $("#pkdel").val();
    $.ajax({
        data: {listar: 'eliminar', pkdel: pkdel},
        url: 'jsp/usuarios.jsp',
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
                $("#usu_nick").val("");
                $("#usu_clave").val("");
                $("#usu_rol").val("0");
                $("#fk").val("");
                $("#selectPersonal").val("").prop('selectedIndex', 0);
                $("#usu_clave").prop("disabled", false);
                $("#usu_clave").prop("title", "Ingrese clave para usuario");
                $("#usu_clave").prop("placeholder", "Ingrese clave para usuario");
            }
            listadousuariosajax();
            $("#art_nombre").focus();
        }
    });
});
function rellenarpersonal() {
    $.ajax({
        data: {listar: 'buscarpersonal'},
        url: 'jsp/usuarios.jsp',
        type: 'post',
        success: function (response) {
            $("#selectPersonal").html(response);
        }
    });
}
function dividirpersonal(a) {
    datosp = a.split(',');
    $("#fk").val(datosp[0]);
    $("#det_ped_precio_unitario").val(datosp[1]);
}
$("#cancelar").on('click', function () {
    $("#form")[0].reset();
    $("#listar").val("cargar");
});
