*** POR HACER ***

- Agregar estado a personales.

- Crear CSS individual para mudar los style de tabla abm

- a reporte_pedido.jsp que el nro de comprobante aumente

- estado de factura debe ser cobrada en vez de pagada


* * * VARIABLES PARA VALIDACIÓN DE DUPLICADOS * * *
0 ya existe
1 insertado correctamente
2 modificado correctamente
3 Datos eliminados...

### EDICIONES ###
BOTONES
- REPORTE
class="badge rounded-pill gradient-blue"

-Agregar
class="btn btn-success"

- CANCELAR
<button type="button" class="btn btn-danger" id="cancelar" name="cancelar">CANCELAR</button>
$("#cancelar").on('click', function () {
    $("#form")[0].reset();
    $("#listar").val("cargar");
});

- ACCIONES
class="badge rounded-pill gradient-grey"

- ASTERISCO OBLIGATORIO
<span style="color: red;cursor: pointer;" title="OBLIGATORIO" >*</span>




GLOSARIO
ABM
BASE DE DATOS


select * from pedidos ped INNER JOIN usuarios usu ON ped.ped_usu_id_fk = usu.usu_id INNER JOIN clientes cli ON ped.ped_cli_id_fk = cli.cli_id WHERE ped_id = 26

# # # ESTADOS # # #
FINALIZADO
COBRADO
FACTURADO
