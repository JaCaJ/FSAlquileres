$(document).ready(function () {
    mostrarPedidos();
    rellenarUsuario();
});
function rellenarUsuario() {
    $.ajax({
        data: {listar: 'buscarusuario'},
        url: 'jsp/deCaja.jsp',
        type: 'post',
        success: function (response) {
            $("#selectUsuario").html(response);
        }
    });
}
function dividirusuario(a) {
    datosp = a.split(',');
    $("#usuariofk").val(datosp[0]);
}
function abrirReporte(fecha_desde, fecha_hasta, usuario) {
    if (fecha_desde == "") {
        alert("Debe ingresar una fecha desde.")
        $('#fecha_desde').focus();
        return false;
    }
    if (fecha_hasta == "") {
        alert("Debe ingresar una fecha hasta.")
        $('#fecha_hasta').focus();
        return false;
    }
    window.open('jsp/informeCaja.jsp?fecha_desde=' + fecha_desde + '&fecha_hasta=' + fecha_hasta + '&usuario=' + usuario, '_blank');

    /*
     window.open('jsp/informePedidos.jsp?fecha_desde=' + encodeURIComponent(fecha_desde) + '&fecha_hasta=' + encodeURIComponent(fecha_hasta) + '&usuario=' + encodeURIComponent(usuario) + '&cliente=' + encodeURIComponent(cliente), '_blank');
     */
}
function mostrarPedidos() {
    $.ajax({
        data: {listar: 'listar'},
        url: 'jsp/dePedido.jsp',
        type: 'post',
        success: function (response) {
            $("#resultados").html(response);
        }
    });
}
