function validarContrasena() {
    const contrasenaVieja = document.getElementById('cv').value;
    const nuevaContrasena = document.getElementById('cn').value;
    const confirmarContrasena = document.getElementById('vc').value;
    let isValid = true; 

    // Validación de que la nueva contraseña no sea igual a la antigua
    if (contrasenaVieja === nuevaContrasena) {
        mostrarError('cn', 'vc', 'cv', '¡La nueva contraseña no puede ser igual a la anterior!');
        isValid = false;
    } else {
        limpiarError('cn', 'vc', 'cv');
    }
    // Validación de coincidencia entre nueva contraseña y confirmación
    if (nuevaContrasena && confirmarContrasena) {
        if (nuevaContrasena !== confirmarContrasena) {
            mostrarError('cn', 'vc', null, '¡Las contraseñas no coinciden!');
            isValid = false;
        } else {
            mostrarExito('cn', 'vc', 'Las contraseñas coinciden.');
        }
    }
    // Verificar que las contraseñas no estén vacías
    if (contrasenaVieja === "" || nuevaContrasena === "" || confirmarContrasena === "") {
        mostrarError('cv', 'cn', 'vc', '¡Todos los campos son obligatorios!');
        isValid = false;
    }
    return isValid;
}
function mostrarError(id1, id2, id3, mensaje) {
    if (id1)
        $("#" + id1).css("border-color", "red");
    if (id2)
        $("#" + id2).css("border-color", "red");
    if (id3)
        $("#" + id3).css("border-color", "red");
    $("#mensajeContrasena1").html(mensaje).css("color", "red");
}
function limpiarError(id1, id2, id3) {
    if (id1)
        $("#" + id1).css("border-color", "");
    if (id2)
        $("#" + id2).css("border-color", "");
    if (id3)
        $("#" + id3).css("border-color", "");
    $("#mensajeContrasena1").html("").css("color", "");
}
function mostrarExito(id1, id2, mensaje) {
    $("#" + id1).css("border-color", "green");
    $("#" + id2).css("border-color", "green");
    $("#mensajeContrasena2").html(mensaje).css("color", "green");
}
$("#cambioClave").on('click', function () {
    const contrasenaVieja = document.getElementById('cv').value;
    const nuevaContrasena = document.getElementById('cn').value;
    const confirmarContrasena = document.getElementById('vc').value;
    if (validarContrasena() && contrasenaVieja !== "" && nuevaContrasena !== "" && confirmarContrasena !== "") {
        $.ajax({
            data: {listar: "cambio", cv: contrasenaVieja, cn: nuevaContrasena},
            url: 'jsp/contrasena.jsp',
            type: 'POST',
            success: function (response) {
                alert(response); 
                $("#cv").css("border-color", "");
                $("#cn").css("border-color", "");
                $("#vc").css("border-color", "");
                $("#cv").val("");
                $("#cn").val("");
                $("#vc").val("");
                $("#mensajeContrasena1").html("").css("color", "");
                $("#mensajeContrasena2").html("").css("color", "");
            },
            error: function (error) {
                alert('Hubo un error al cambiar la contraseña: ' + error.statusText);
            }
        });
    }
});
$("#no").on('click', function () {
    $("#cv").css("border-color", "");
    $("#cn").css("border-color", "");
    $("#vc").css("border-color", "");
    $("#cv").val("");
    $("#cn").val("");
    $("#vc").val("");
    $("#mensajeContrasena1").html("").css("color", "");
    $("#mensajeContrasena2").html("").css("color", "");
});

