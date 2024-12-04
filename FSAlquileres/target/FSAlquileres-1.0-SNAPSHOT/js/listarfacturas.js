$(document).ready(function () {
    mostrarPedidos();
    listarFacturas();
});
function cobrarpedido(idpedido) {
    if ($("#estadocaja").html().includes('CERRADA')) {
        alert('¡Caja cerrada! Para continuar primero debe abrirla.');
        return false;
    }
    if ($("#estadocaja").html().includes('ABIERTA')) {
        $.ajax({
            data: {listar: 'cobrarpedido', idpedido: idpedido},
            url: 'jsp/listarfacturas.jsp',
            type: 'post',
            success: function (response) {
                //$("#resultados").html(response);
                if (response.includes('cobrado')) {
                    alert("PEDIDO COBRADO EXITOSAMENTE");
                    mostrarPedidos();
                }
            }
        });
    }
}
function reimprimirFactura(idfactura) {
    window.open('jsp/factura_envioDatos.jsp?idfactura=' + idfactura, '_blank');
}
function cobrarfactura(idfactura) {
    if ($("#estadocaja").html().includes('CERRADA')) {
        alert('¡Caja cerrada! Para continuar primero debe abrirla.');
        return false;
    }
    if ($("#estadocaja").html().includes('ABIERTA')) {
        $.ajax({
            data: {listar: 'cobrarfactura', idfactura: idfactura},
            url: 'jsp/listarfacturas.jsp',
            type: 'post',
            success: function (response) {
                //$("#resultados").html(response);
                if (response.includes('COBRADA')) {
                    alert("FACTURA COBRADA EXITOSAMENTE.");
                    listarFacturas();
                }
            }
        });
    }
}
function generarFactura(idpedido, estado) {
    if ($("#estadocaja").html().includes('CERRADA')) {
        alert(estado);
        alert("La caja está CERRADA, favor ábrala antes de continuar.");
        return false;
    }
    if ($("#estadocaja").html().includes('ABIERTA')) {
        $.ajax({
            data: {idpedido: idpedido, estado: estado},
            url: 'jsp/facturaSPedido.jsp',
            type: 'post',
            success: function (response) {
                let datos = JSON.parse(response);
                window.open('jsp/facturaSPedido_envioDatos.jsp?factura_actual=' + datos[0] + '&montoTotal=' + datos[1], '_blank');
                mostrarPedidos();
                listarFacturas();
            }
        });
    }
}
function mostrarPedidos() {
    $.ajax({
        data: {listar: 'listarpedidos'},
        url: 'jsp/listarfacturas.jsp',
        type: 'post',
        success: function (response) {
            $("#resultados").html(response);
        }
    });
}
function listarFacturas() {
    $.ajax({
        data: {listar: 'listarfacturas'},
        url: 'jsp/listarfacturas.jsp',
        type: 'post',
        success: function (response) {
            $("#facturas").html(response);
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
$("#anular-factura").click(function () {
    idfactura = $("#idfactura").val();
    $.ajax({
        data: {listar: 'anularfactura', idfactura: idfactura},
        url: 'jsp/listarfacturas.jsp',
        type: 'post',
        success: function (response) {
            if (response.includes("Factura anulada")){
                alert("La factura se anuló correctamente");
            }else{
                alert("ATENCIÓN: La factura no se anuló.");
            }
            
            listarFacturas();
        }
    });
})
$("#btn_pedidos").click(function () {
    mostrarPedidos();
})