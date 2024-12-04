<%@include file="header.jsp"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page import="java.math.BigInteger"%>
<%@page import="java.security.MessageDigest"%>
<%
    // Obtener la fecha actual
    Date fechaActual = new Date();

    // Crear un formateador de fecha
    SimpleDateFormat formateadorFecha = new SimpleDateFormat("dd-MM-yyyy");

    // Formatear la fecha
    String fechaFormateada = formateadorFecha.format(fechaActual);
%>
<div class="content-wrapper">
    <div class="row gutters">
        <div class="col-sm-12 col-12">
            <div class="card gradient-dark-grey">
                <div class="card-header">
                    <div class="card-title">AGENDAR PEDIDO</div>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-sm-6 col-12">
                            <div class="product-block">
                                <!--<div class="product-title">General Information</div>-->
                                <div class="product-body">
                                    <div class="row gutters">
                                        <div class="col-sm-6 col-12">
                                            <div class="mb-3 control-dark">

                                                <form action="#" id="form" method="POST" role="form">

                                                    <input type="hidden" id="listar" name="listar" value="cargar"/>
                                                    <!--<input type="" id="ped_id" name="ped_id" >-->

                                                    <!-- Field wrapper start -->
                                                    <div class="mb-3 control-dark">
                                                        <div class="form-label">FECHA PEDIDO<span class="text-red"> *</span></div>
                                                        <input type="text" class="form-control" id="ped_fecha_pedido" name="ped_fecha_pedido" value="<% out.print(fechaFormateada); %>" readonly="" />
                                                    </div>
                                                    <div class="mb-3 control-dark">
                                                        <div class="form-label">FECHA RETIRO<span class="text-red"> *</span></div>
                                                        <input class="form-control datepicker-input input-group" 
                                                               type="date" name="ped_fecha_retiro" id="ped_fecha_retiro" onchange="validarfecharetiro()">
                                                    </div>
                                                    <div class="mb-3 control-dark">
                                                        <div class="form-label">TELEFONO CLIENTE<span class="text-red"> *</span></div>
                                                        <input type="text" class="form-control" id="cel_cliente" name="cel_cliente" oninput="validarSoloNumeros(this)" placeholder="Inserte telefono del cliente"/>
                                                    </div>
                                                    <!-- Field wrapper end -->
                                            </div>
                                        </div>
                                        <div class="col-sm-6 col-12">
                                            <div class="mb-3 control-dark">
                                                <div class="form-label">FECHA ENTREGA<span class="text-red"> *</span></div>
                                                <input class="form-control datepicker-input input-group" 
                                                       type="date" name="ped_fecha_entrega" id="ped_fecha_entrega" onchange="validarfechaentrega()">
                                            </div>

                                            <div class="mb-3 control-dark">
                                                <label class="form-label">CLIENTE
                                                    <span class="text-red">*</span></label>
                                                <input type="hidden" id="ped_usu_id_fk" name="ped_usu_id_fk" value="<% out.print(sesion.getAttribute("id"));
                                                       %>">
                                                <select class="form-select" name="cliente" id="cliente" onchange="dividircliente(this.value)">
                                                </select>
                                                <input type="hidden" id="ped_cli_id_fk" name="ped_cli_id_fk" placeholder="ped_cli_id_fk">
                                            </div>
                                            <div class="mb-3 control-dark">
                                                <div class="form-label">CI CLIENTE<span class="text-red"> *</span></div>
                                                <input type="text" class="form-control" id="ci_cliente" readonly="" placeholder="CI del cliente"/>
                                            </div>
                                        </div>
                                        <div class="col-sm-12 col-12">
                                            <div class="mb-3 control-dark">
                                                <label class="form-label">DIRECCION DE ENTREGA
                                                    <span class="text-red">*</span></label>
                                                <textarea rows="4" class="form-control"
                                                          placeholder="Dirección de entrega" id="ped_direccion" name="ped_direccion"></textarea>
                                            </div>
                                            <div class="mb-3 control-dark">
                                                <label class="form-label">OBSERVACIÓN
                                                    <span class="text-red">*</span></label>
                                                <textarea rows="4" class="form-control"
                                                          placeholder="Observacion" id="ped_observacion" name="ped_observacion"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-6 col-12">
                            <div class="product-block">
                                <!--<div class="product-title">Meta Data</div>-->
                                <div class="product-body">
                                    <div class="row gutters">
                                        <div class="col-sm-6 col-12">
                                            <div class="mb-3 control-dark">
                                                <input type="hidden" id="codproducto" name="codproducto">
                                                <label class="form-label">ARTÍCULO
                                                    <span class="text-red">*</span></label>
                                                <select class="form-select" name="articulo" id="articulo" onchange="dividirproducto(this.value)">
                                                </select>
                                            </div>
                                            <div class="mb-3 control-dark">
                                                <input type="hidden" id="codservicio" name="codservicio">
                                                <label class="form-label">SERVICIO
                                                    <span class="text-red">*</span></label>
                                                <select class="form-select" name="servicio" id="servicio" onchange="dividirservicio(this.value)">
                                                </select>
                                            </div>
                                        </div>

                                        <div class="col-sm-6 col-12">
                                            <div class="mb-3 control-dark">
                                                <label class="form-label">CANTIDAD
                                                    <span class="text-red">*</span></label>
                                                <input type="text" class="form-control" placeholder="Inserte una cantidad" id="det_ped_cantidad_pedido" name="det_ped_cantidad_pedido" oninput="validarSoloNumeros(this)"/>
                                            </div>
                                            <div class="mb-3 control-dark">
                                                <label class="form-label">PRECIO
                                                    <span class="text-red">*</span></label>
                                                <input type="text" class="form-control" placeholder="Inserte el precio" id="det_ped_precio_unitario" name="det_ped_precio_unitario" oninput="validarSoloNumeros(this)"/>
                                            </div>
                                            <br>                                                
                                            <div class="custom-btn-group flex-end">
                                                
                                                <button type="button" class="btn btn-primary" id="AgregaArticuloPedido" name="AgregaArticuloPedido">
                                                    AGREGAR
                                                </button>
                                            </div>
                                            <div id="respuesta"></div>
                                            <div id="mensaje"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <input type="hidden" id="ped_costo_total" name="ped_costo_total"/>

                        </form>

                        <div class="col-sm-12 col-12">
                            <div class="product-block">
                                <div class="product-title">DETALLE PEDIDO</div>
                                <div class="product-body">
                                    <div class="col-sm-12 col-12">
                                        <div class="card gradient-dark-grey">
                                            <div class="card-body">
                                                <div class="table-responsive">
                                                    <table class="table table-bordered m-0" >
                                                        <thead>
                                                            <tr>
                                                                <th>ACCIONES</th>
                                                                <th>ID</th>
                                                                <th>ARTICULO</th>
                                                                <th>PRECIO</th>
                                                                <th>CANTIDAD</th>
                                                                <th>TOTAL</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody id="resultados">

                                                        </tbody>
                                                        <tfoot>
                                                            <tr>
                                                                <td colspan="3"> </td>
                                                            </tr>
                                                        </tfoot>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                                                <div class="product-title"><label class="form-label text-start">MONTO TOTAL:</label> <div id="lbltotal" name="lbltotal" class="blanco"></div></div>
                        <div class="col-sm-12 col-12">
                            <div class="custom-btn-group flex-end">
                                <button type="button" class="btn btn-light" id="btn-cancelar">
                                    Cancelar
                                </button>
                                <button type="button" class="btn btn-success" id="btn-finalizar" name="btn-finalizar">
                                    Finalizar
                                </button>                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Row end -->
    <!-- Modal Dark -->
    <div class="modal modal-dark fade" id="modalDark" tabindex="-1" aria-labelledby="modalDarkLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalDarkLabel">
                        ELIMINAR PEDIDO
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                            aria-label="Close"></button>
                </div>
                <input type="hidden" id="idpk" name="idpk">
                <input type="hidden" id="cantPed" name="cantPed">
                <input type="hidden" id="idser" name="idser">
                <input type="hidden" id="idart" name="idart">

                <div class="modal-body">¿Está seguro que desea eliminar el registro?</div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-dark" data-bs-dismiss="modal">
                        NO
                    </button>
                    <button type="button" class="btn btn-success" id="eliminar-registro-detalle" data-bs-dismiss="modal">
                        Si
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Required jQuery first, then Bootstrap Bundle JS -->
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/bootstrap.bundle.min.js"></script>
<script src="assets/js/modernizr.js"></script>
<script src="assets/js/moment.js"></script>

<!-- *************
        ************ Vendor Js Files *************
************* -->

<!-- Overlay Scroll JS 
<script src="assets/vendor/overlay-scroll/jquery.overlayScrollbars.min.js"></script>
<script src="assets/vendor/overlay-scroll/custom-scrollbar.js"></script>
-->
<!-- Input Mask JS -->
<script src="assets/vendor/input-masks/cleave.min.js"></script>
<script src="assets/vendor/input-masks/cleave-phone.js"></script>
<script src="assets/vendor/input-masks/cleave-custom.js"></script>

<!--<!-- añadidos por mí -->
<script src="js/pedidos.js"></script>
<script>

                                                    function validarSoloNumeros(input) {
                                                        var re = /^[0-9]*$/;
                                                        let msg = input.value;
                                                        if (!(msg.match(re) !== null)) {
                                                            input.value = msg.slice(0, msg.length - 1);
                                                        }
                                                    }
</script>
<%@include file="footer.jsp"%>