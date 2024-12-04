$(document).ready(function () {
    estadoCaja();
});

function estadoCaja() {
    usu = $("#usu").val();
    $.ajax({
        data: {listar: 'consultarcaja', usu: usu},
        url: 'jsp/caja.jsp',
        type: 'post',
        success: function (response) {
            //if response
            $("#estadocaja").html(response);
        }
    });
}
$("#abrircaja").on('click', function () {
    if($('#montoi').val() == ""){
        alert('Debe ingresar un monto inicial.');
        return false;
    }
    if ($("#estadocaja").html().includes('ABIERTA')) {
        alert('Error: ¡LA CAJA YA ESTÁ ABIERTA!');
    } else {
        montoi = $('#montoi').val();
        usu = $('#usu').val();
        $.ajax({
            data: {listar: 'abrircaja', montoi: montoi, usu: usu},
            url: 'jsp/caja.jsp',
            type: 'post',
            success: function (response) {
                if (response.includes("Caja abierta")) {
                    $("#estadocaja").html('ABIERTA');
                    alert("Caja abierta exitosamente.");
                    $('#montoi').val("");
                } else {
                    alert("Error: No se pudo abrir la caja.");
                }
            }
        });
    }
});
$("#cerrarcaja").on('click', function () {
    if ($("#estadocaja").html().includes('CERRADA')) {
        alert('Error: ¡LA CAJA YA ESTÁ CERRADA!');
    } else {
        usu = $('#usu').val();
        $.ajax({
            data: {listar: 'cerrarcaja', usu: usu},
            url: 'jsp/caja.jsp',
            type: 'post',
            success: function (response) {
                if (response.includes("Caja cerrada")) {
                    $("#estadocaja").html('CERRADA');
                    alert("Caja cerrada exitosamente.");
                } else {
                    alert("Error: No se pudo cerrar la caja.");
                }
            }
        });
    }
});


