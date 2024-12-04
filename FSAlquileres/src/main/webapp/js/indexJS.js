$(document).ready(function () {

});
$("#boton").on('click', function () {
    if ($("#usuario").val() === "") {
        alert('Debe ingresar un usuario.');
        $("#usuario").focus();
        return false;
    }
    if ($("#pswrd").val() === "") {
        alert('Debe ingresar una contraseña.');
        $("#pswrd").focus();
        return false;
    }
    datosformulario = $("#form").serialize();
    $.ajax({
        data: datosformulario,
        url: 'jsp/indexJSP.jsp',
        type: 'post',
        success: function (response) {
            $("#usuario").val("");
            $("#usuario").focus();
            $("#pswrd").val("");
            $("#mensaje").html(response)
            
        }
    });
});