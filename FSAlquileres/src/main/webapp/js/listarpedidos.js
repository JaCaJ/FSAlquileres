$(document).ready(function () {
    mostrarPedidos();
});
function validarSoloNumeros(input) {
    var re = /^[0-9]*$/;
    let msg = input.value;
    if (!(msg.match(re) !== null)) {
        input.value = msg.slice(0, msg.length - 1);
    }
}
$("#btn_devolver").click(function () {
    listar = $("#listar").val();
    id_pedido = $("#idd").text();
    datosdevolucion = $("#form").serialize();
    $.ajax({
        data: {listar: listar, id_pedido: id_pedido, datosdevolucion: datosdevolucion},
        url: 'jsp/listarpedidos.jsp',
        type: 'post',
        success: function (response) {
            if (response.includes("Devuelto satisfactoriamente")){
                alert("Devuelto satisfactoriamente");
            }
            if (response.includes("Cabecera factura Cargada")){
                alert("Se hallaron articulos o servicios faltantes.");
                window.open('jsp/factura_envioDatos.jsp?idfactura=' + response.split("-")[1], '_blank');
            }
            mostrarPedidos();
        }
    });
});
//se refiere a la columna izquieda del modal que se abre al presionar el botón devolver.
function cargarenviados(idpedido) {
    $.ajax({
        data: {listar: 'listarenviados', idpedido: idpedido},
        url: 'jsp/listarpedidos.jsp',
        type: 'post',
        beforeSend: function () {
        },
        success: function (response) {
            $("#enviados").html(response);
        }
    });
}
//se refiere a la columna derecha del modal que se abre al presionar el botón devolver.
function cargarrecibidos(idpedido) {
    $.ajax({
        data: {listar: 'listarrecibidos', idpedido: idpedido},
        url: 'jsp/listarpedidos.jsp',
        type: 'post',
        beforeSend: function () {
        },
        success: function (response) {
            $("#recibidos").html(response);
        }
    });
}
function abrirReporte(idUsu, montoTotal) {
    window.open('jsp/reporte_pedido.jsp?idRep=' + idUsu + '&montoTotal=' + montoTotal, '_blank');
}
//se refiere a los span que estan arribaite del modal de devolucion
function cargarcabecera(idpedido) {
    $.ajax({
        data: {listar: 'cargarcabecera', idpedido: idpedido},
        url: 'jsp/listarpedidos.jsp',
        type: 'post',
        success: function (response) {
            let cab = JSON.parse(response)
            $("#idd").text(cab[0]);
            $("#cliente").text(cab[4] + " " + cab[2] + " " + cab[3]);
            $("#fecha").text(cab[1]);
            $("#total").text(cab[5]);
            cargarenviados(idpedido);
            cargarrecibidos(idpedido);
        }
    });
}
function devolverpedido(idpedido) {
    $.ajax({
        data: {listar: 'devolverpedido', idpedido: idpedido},
        url: 'jsp/listarpedidos.jsp',
        type: 'post',
        success: function (response) {
            $("#cabecera").html(response);
            $("#enviado").html(response);
            $("#recibido").html(response);
        }
    });
}
function mostrarPedidos() {
    $.ajax({
        data: {listar: 'listar'},
        url: 'jsp/listarpedidos.jsp',
        type: 'post',
        success: function (response) {
            $("#resultados").html(response);
        }
    });
}

function entregar(idpedido) {
    $.ajax({
        data: {listar: 'entregar', idpedido: idpedido},
        url: 'jsp/listarpedidos.jsp',
        type: 'post',
        success: function (response) {
            alert(response.trim());
            mostrarPedidos();
        }
    });
}

$("#eliminar-registro-pedido").click(function () {
    pkd = $("#idpk").val();
    $.ajax({
        data: {listar: 'anularpedido', pkd: pkd},
        url: 'jsp/listarpedidos.jsp',
        type: 'post',
        success: function (response) {
            mostrarPedidos();
        }
    });
})