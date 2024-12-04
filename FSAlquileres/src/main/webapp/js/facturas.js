$(document).ready(function () {
    rellenarcampos();
    rellenararticulo();
    rellenarservicio();
    mostrardetalles();
});
$("#AgregaArticuloPedido").click(function () {
    if ($("#ruc_cliente").val() === "") {
        alert('Debe ingresar el RUC del cliente');
        $("#ruc_cliente").focus();
        return false;
    }
    if ($("#razon_social").val() === "") {
        alert('Debe ingresar la razón social del cliente.');
        $("#razon_social").focus();
        return false;
    }
    if ($("#direccion").val() === "") {
        alert('Debe ingresar una dirección.');
        $("#direccion").focus();
        return false;
    }
    if ($("#codarticulo").val() === "" && $("#codservicio").val() === "") {
        alert('Debe seleccionar un artículo o un producto.');
        $("#articulo").focus();
        return false;
    }
    if ($("#cantidad").val() === "") {
        alert('Debe seleccionar una cantidad de artículo.');
        $("#cantidad").focus();
        return false;
    }
    if ($("#precio").val() === "") {
        alert('Debe ingresar un precio.');
        $("#precio").focus();
        return false;
    }
    datosformulario = $("#form").serialize();
    $.ajax({
        data: datosformulario,
        url: 'jsp/facturas.jsp',
        type: 'post',
        success: function (response) {
            $("#mensaje").show();
            $("#mensaje").focus();
            $("#mensaje").html(response);
            rellenararticulo();
            rellenarservicio();
            $("#cantidad").val("");
            $("#precio").val("");
            $("#articulo").val("").prop('selectedIndex', 0);
            $("#servicio").val("").prop('selectedIndex', 0);
            $("#codservicio").val("");
            $("#codarticulo").val("");
            mostrardetalles();
            mostrartotales();
        }
    });
});
function rellenarcampos() {
    $.ajax({
        data: {listar: 'rellenarcampos'},
        url: 'jsp/facturas.jsp',
        type: 'post',
        success: function (response) {
            let cam = JSON.parse(response);
            $("#timbrado").val(cam[0]);
            $("#timbrado").attr("readonly", true);

            $("#ruc_empresa").val(cam[1]);
            $("#ruc_empresa").attr("readonly", true);

            $("#establecimiento").val(cam[2]);
            $("#establecimiento").attr("readonly", true);

            $("#punto").val(cam[3]);
            $("#punto").attr("readonly", true);

            $("#idcaja").val(cam[5]);
            $("#caja").val(1 + " - " + cam[4]);
            $("#caja").attr("readonly", true);

            $("#nro_factura").val(cam[6]);
            $("#nro_factura").attr("readonly", true);

            if (!cam[7] == "") {
                $("#ruc_cliente").val(cam[7]);
                $("#ruc_cliente").attr("readonly", true);

                $("#razon_social").val(cam[8]);
                $("#razon_social").attr("readonly", true);

                $("#direccion").val(cam[9]);
                $("#direccion").attr("readonly", true);
            }
        }
    });
}
function rellenarservicio() {
    $.ajax({
        data: {listar: 'buscarservicio'},
        url: 'jsp/facturas.jsp',
        type: 'post',
        success: function (response) {
            $("#servicio").html(response);
        }
    });
}
function rellenararticulo() {
    $.ajax({
        data: {listar: 'buscararticulo'},
        url: 'jsp/facturas.jsp',
        type: 'post',
        success: function (response) {
            $("#articulo").html(response);
        }
    });
}
function dividirarticulo(a) {
    datosp = a.split(',');
    $("#codarticulo").val(datosp[0]);
    $("#precio").val(datosp[1]);
    $("#servicio").val("").prop('selectedIndex', 0);
    $("#codservicio").val("1");
}
function dividirservicio(b) {
    datosS = b.split(',');
    $("#codservicio").val(datosS[0]);
    $("#precio").val(datosS[1]);
    $("#articulo").val("").prop('selectedIndex', 0);
    $("#codarticulo").val("1");
}
function mostrardetalles() {
    $.ajax({
        data: {listar: 'listar'},
        url: 'jsp/facturas.jsp',
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
        url: 'jsp/facturas.jsp',
        type: 'post',
        beforeSend: function () {
        },
        success: function (response) {
            $("#lbltotal").html(response);
            $("#total_factura").val(response);
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
        data: {listar: 'cancelarfactura'},
        url: 'jsp/facturas.jsp',
        type: 'post',
        beforeSend: function () {
            //$("#resultado").html("Procesando, espere por favor...");
        },
        success: function (response) {
            alert("¡Factura cancelada!");
            location.href = 'facturasHtml.jsp';
        }
    });
});
$("#btn-finalizar").click(function () {
    total = $("#total_factura").val();
    $.ajax({
        data: {listar: 'finalizarfacturacion', total: total},
        url: 'jsp/facturas.jsp',
        type: 'post',
        beforeSend: function () {
            //$("#resultado").html("Procesando, espere por favor...");
        },
        success: function (response) {
            //response = response.trim();
                alert('Facturado correctamente.');
                
                let respuesta = response.split("-");
                let idFactura = respuesta[1].trim(); 
                 window.open('jsp/factura_envioDatos.jsp?idfactura=' + idFactura, '_blank');
             location.href = 'listarfacturasHtml.jsp';

        }
    });
});