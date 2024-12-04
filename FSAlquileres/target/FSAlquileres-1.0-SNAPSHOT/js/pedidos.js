$(document).ready(function () {
    rellenararticulo();
    rellenarcliente();
    mostrardetalles();
    mostrarcabecera();
    rellenarservicio();
});
function validarfechaentrega() {
    fechaa = $('#ped_fecha_pedido').val();
    datosf = fechaa.split('-');
    fechaaux = datosf[2] + "-" + datosf[1] + "-" + datosf[0]

    var fechaentrega = new Date($('#ped_fecha_entrega').val());
    var fechaactual = new Date(fechaaux);
    // Mostrar las fechas para depuración
    //alert("Fecha de entrega: " + fechaentrega);
    //alert("Fecha actual: " + fechaactual);
    if (fechaentrega < fechaactual) {
        alert("No se puede agendar un pedido en fecha anterior a la actual.");
        $('#ped_fecha_entrega').val("");
        $('#ped_fecha_entrega').focus();
    }
}
function validarfecharetiro() {
    var fechaentrega = new Date($('#ped_fecha_entrega').val());
    var fecharetiro = new Date($('#ped_fecha_retiro').val());
    // Mostrar las fechas para depuración
    //alert("Fecha de entrega: " + fechaentrega);
    //alert("Fecha actual: " + fecharetiro);
    if(fechaentrega == "Invalid Date"){
        alert("Primero debe seleccionar una fecha de entrega");
        $('#ped_fecha_retiro').val("");
        $('#ped_fecha_entrega').focus();
    }
    if (fecharetiro < fechaentrega) {
        alert("No se puede retirar un pedido en fecha anterior a la de entrega.");
        $('#ped_fecha_retiro').val("");
        $('#ped_fecha_retiro').focus();
    }
}

function mostrarcabecera() {
    $.ajax({
        data: {listar: 'listarcabecera'},
        url: 'jsp/busqueda.jsp',
        type: 'post',
        beforeSend: function () {
        },
        success: function (response) {
            //$("#").html(response);
            let cab = JSON.parse(response);
            $("#ped_fecha_pedido").val(cab[1]);
            $("#ped_fecha_pedido").prop("disabled", true);

            $("#ped_fecha_entrega").val(cab[2]);
            $("#ped_fecha_entrega").prop("disabled", true);

            $("#ped_fecha_retiro").val(cab[3]);
            $("#ped_fecha_retiro").prop("disabled", true);

            $("#cliente").val(cab[12] + "," + cab[15] + "," + cab[16] + "," + cab[17] + "," + cab[18]);
            $("#cliente").prop("disabled", true);

            $("#cel_cliente").val(cab[10]);
            $("#cel_cliente").prop("disabled", true);

            $("#ci_cliente").val(cab[14]);
            $("#ci_cliente").prop("disabled", true);

            $("#ped_direccion").val(cab[9]);
            $("#ped_direccion").prop("disabled", true);

            $("#ped_observacion").val(cab[4]);
            //$("#ped_observacion").prop("disabled", true);         

            //$("#").val(cab[]);
            //$("#").prop("disabled", true);         

        }
    });
}
$("#AgregaArticuloPedido").click(function () {
    if ($("#ped_fecha_entrega").val() === "") {
        alert('Debe ingresar una fecha de entrega.');
        $("#ped_fecha_entrega").focus();
        return false;
    }
    if ($("#ped_fecha_retiro").val() === "") {
        alert('Debe ingresar una fecha de retiro.');
        $("#ped_fecha_retiro").focus();
        return false;
    }
    if ($("#ci_cliente").val() === "") {
        alert('Debe seleccionar un cliente.');
        $("#cliente").focus();
        return false;
    }
    if ($("#codproducto").val() === "" && $("#codservicio").val() === "") {
        alert('Debe seleccionar un artículo o un producto.');
        $("#articulo").focus();
        return false;
    }
    if ($("#det_ped_cantidad_pedido").val() === "") {
        alert('Debe seleccionar una cantidad de artículo.');
        $("#det_ped_cantidad_pedido").focus();
        return false;
    }
    if ($("#ped_direccion").val() === "") {
        alert('Debe ingresar una direccion para la entrega.');
        $("#ped_direccion").focus();
        return false;
    }
    if ($("#cel_cliente").val() === "") {
        alert('Debe ingresar un número de teléfono.');
        $("#cel_cliente").focus();
        return false;
    }
    datosformulario = $("#form").serialize();
    $.ajax({
        data: datosformulario,
        url: 'jsp/busqueda.jsp',
        type: 'post',
        success: function (response) {
            if (response.includes("Ya existe el artículo/servicio")) {
                alert(response);
                $("#det_ped_cantidad_pedido").focus();
                return false;
            } else if (response.includes("Error: Artículo")) {
                $("#det_ped_cantidad_pedido").focus();
                alert(response);
                return false;
            } else if (response.includes("Error: Cantidad")) {
                $("#det_ped_cantidad_pedido").focus();
                alert(response);
                return false;
            } else {
                $("#mensaje").show();
                $("#mensaje").focus();
                $("#mensaje").html(response);
                mostrardetalles();
                rellenararticulo();
                rellenarservicio();
                $("#det_ped_cantidad_pedido").val("");
                $("#det_ped_precio_unitario").val("");
                $("#articulo").val("").prop('selectedIndex', 0);
                $("#servicio").val("").prop('selectedIndex', 0);
                $("#codservicio").val("");
                $("#codproducto").val("");
            }
        }
    });
});
function rellenararticulo() {
    $.ajax({
        data: {listar: 'buscararticulo'},
        url: 'jsp/busqueda.jsp',
        type: 'post',
        success: function (response) {
            $("#articulo").html(response);
        }
    });
}
function rellenarservicio() {
    $.ajax({
        data: {listar: 'buscarservicio'},
        url: 'jsp/busqueda.jsp',
        type: 'post',
        success: function (response) {
            $("#servicio").html(response);
        }
    });
}
function rellenarcliente() {
    $.ajax({
        data: {listar: 'buscarcliente'},
        url: 'jsp/busqueda.jsp',
        type: 'post',
        success: function (response) {
            $("#cliente").html(response);
        }
    });
}
function dividirproducto(a) {
    datosp = a.split(',');
    $("#codproducto").val(datosp[0]);
    $("#det_ped_precio_unitario").val(datosp[1]);
    $("#servicio").val("").prop('selectedIndex', 0);
    $("#codservicio").val("1");
}
function dividirservicio(b) {
    datosS = b.split(',');
    $("#codservicio").val(datosS[0]);
    $("#det_ped_precio_unitario").val(datosS[1]);
    $("#articulo").val("").prop('selectedIndex', 0);
    $("#codproducto").val("1");
}
function dividircliente(a) {
    datosc = a.split(',');
    $("#ped_cli_id_fk").val(datosc[0]);
    $("#ci_cliente").val(datosc[1]);
    $("#cel_cliente").val(datosc[2]);
    $("#ped_direccion").val(datosc[3] + " " + datosc[4]);
}
function mostrardetalles() {
    $.ajax({
        data: {listar: 'listar'},
        url: 'jsp/busqueda.jsp',
        type: 'post',
        beforeSend: function () {
        },
        success: function (response) {
            $("#resultados").html(response);
            mostrartotales();
        }
    });
}
function mostrartotales() {
    $.ajax({
        data: {listar: 'mostrartotales'},
        url: 'jsp/busqueda.jsp',
        type: 'post',
        beforeSend: function () {
        },
        success: function (response) {
            $("#lbltotal").html(response);
            $("#ped_costo_total").val(response);
        }
    });
}
$("#eliminar-registro-detalle").click(function () {
    pk = $("#idpk").val();
    cantPed = $("#cantPed").val();
    idser = $("#idser").val();
    idart = $("#idart").val();

    $.ajax({
        data: {listar: 'eliminardetalle', pk: pk, cantPed: cantPed, idser: idser, idart: idart},
        url: 'jsp/busqueda.jsp',
        type: 'post',
        beforeSend: function () {
            //$("#resultado").html("Procesando, espere por favor...");
        },
        success: function (response) {
            mostrardetalles();
            rellenararticulo();
            rellenarservicio();
            $("#idpk").val("");
            $("#cantPed").val("");
            $("#idser").val("");
            $("#idart").val("");
            $("#det_ped_cantidad_pedido").val("");
            $("#det_ped_precio_unitario").val("");
            pk = 0;
            cantPed = 0;
            idser = 0;
            idart = 0;
            
        }
    });

});
$("#btn-cancelar").click(function () {
    //pk = $("#idpk").val();
    $.ajax({
        data: {listar: 'cancelarpedido'},
        url: 'jsp/busqueda.jsp',
        type: 'post',
        beforeSend: function () {
            //$("#resultado").html("Procesando, espere por favor...");
        },
        success: function (response) {
            alert("¡Pedido cancelado!");
            location.href = 'listarpedidosHtml.jsp';
        }
    });
});
$("#btn-finalizar").click(function () {
    total = $("#ped_costo_total").val();
    observacion = $("#ped_observacion").val();
    $.ajax({
        data: {listar: 'finalizarventa', total: total, observacion: observacion},
        url: 'jsp/busqueda.jsp',
        type: 'post',
        beforeSend: function () {
            //$("#resultado").html("Procesando, espere por favor...");
        },
        success: function (response) {
            alert('Agendado correctamente.');
            location.href = 'listarpedidosHtml.jsp';
        }
    });
});