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
                    <div class="card-title">GENERAR FACTURA</div>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-sm-12 col-12">
                            <div class="product-block">
                                <!--<div class="product-title">General Information</div>-->
                                <div class="product-body">
                                    <div class="row gutters">
                                        <div class="col-sm-3 col-12">
                                            <div class="mb-3 control-dark">
                                                <form action="#" id="form" method="POST" role="form">
                                                    <input type="hidden" id="listar" name="listar" value="cargar"/>
                                                    <!-- Field wrapper start -->
                                                    <div class="mb-3 control-dark">
                                                        <div class="form-label">FECHA ACTUAL<span class="text-red"> *</span></div>
                                                        <input type="text" class="form-control" id="fecha_actual" name="fecha_actual" value="<% out.print(fechaFormateada);
                                                               %>" readonly="" />
                                                    </div>

                                                    <div class="mb-3 control-dark">
                                                        <div class="form-label">PUNTO<span class="text-red"> *</span></div>
                                                        <input type="text" class="form-control" id="punto" name="punto" placeholder="Inserte telefono del cliente"/>
                                                    </div>
                                                    <div class="mb-3 control-dark">
                                                        <label class="form-label">RUC CLIENTE
                                                            <span class="text-red">*</span></label>
                                                        <input type="text" class="form-control"
                                                               placeholder="Ingrese el RUC del cliente." id="ruc_cliente" name="ruc_cliente" maxlength="10">
                                                    </div>

                                            </div>
                                        </div>
                                        <div class="col-sm-3 col-12">
                                            <div class="mb-3 control-dark">
                                                <div class="form-label">CONDICION<span class="text-red"> *</span></div>
                                                <input class="form-control datepicker-input input-group" 
                                                       type="text" name="condicion" id="condicion" value="CONTADO" readonly>
                                            </div>

                                            <div class="mb-3 control-dark">
                                                <div class="form-label">ESTABLECIMIENTO<span class="text-red"> *</span></div>
                                                <input type="text" class="form-control" id="establecimiento" name="establecimiento" readonly/>
                                            </div>
                                            <div class="mb-3 control-dark">
                                                <label class="form-label">RAZON SOCIAL
                                                    <span class="text-red">*</span></label>
                                                <input type="text" class="form-control"
                                                       placeholder="Inserte aquí la razón social." id="razon_social" name="razon_social" maxlength="80">
                                            </div>
                                        </div>
                                        <div class="col-sm-3 col-12">
                                            <div class="mb-3 control-dark">
                                                <div class="form-label">TIMBRADO<span class="text-red"> *</span></div>
                                                <input class="form-control datepicker-input input-group" 
                                                       type="text" name="timbrado" id="timbrado" value="" readonly>
                                            </div>
                                            <div class="mb-3 control-dark">
                                                <div class="form-label">N&deg; DE FACTURA<span class="text-red"> *</span></div>
                                                <input type="text" class="form-control" id="nro_factura" name="nro_factura"/>
                                            </div>
                                        </div>
                                        <div class="col-sm-3 col-12">
                                            <div class="mb-3 control-dark">
                                                <label class="form-label">RUC EMPRESA
                                                    <span class="text-red">*</span></label>
                                                <input type="text" class="form-control" id="ruc_empresa" name="ruc_empresa" value="">
                                            </div>
                                            <div class="mb-3 control-dark">
                                                <div class="form-label">CAJA<span class="text-red"> *</span></div>
                                                <input type="hidden" id="idcaja" name="idcaja"/>
                                                <input type="text" class="form-control" id="caja" name="caja" readonly/>
                                            </div>
                                        </div>
                                        <div class="col-sm-6 col-12">
                                            <div class="mb-3 control-dark">
                                                <label class="form-label">DIRECCION
                                                    <span class="text-red">*</span></label>
                                                <input type="text" class="form-control"
                                                       placeholder="Ingrese la dirección del cliente." id="direccion" name="direccion">
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
                                                <input type="hidden" id="codarticulo" name="codarticulo">
                                                <label class="form-label">ARTÍCULO
                                                    <span class="text-red">*</span></label>
                                                <select class="form-select" name="articulo" id="articulo" onchange="dividirarticulo(this.value)">
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
                                                <input type="text" class="form-control" placeholder="Inserte una cantidad" id="cantidad" name="cantidad" oninput="validarSoloNumeros(this)"/>
                                            </div>
                                            <div class="mb-3 control-dark">
                                                <label class="form-label">PRECIO
                                                    <span class="text-red">*</span></label>
                                                <input type="text" class="form-control" placeholder="Inserte el precio" id="precio" name="precio" oninput="validarSoloNumeros(this)"/>
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
                        <input type="hidden" id="total_factura" name="total_factura"/>

                        </form>

                        <div class="col-sm-12 col-12">
                            <div class="product-block">
                                <div class="product-title">DETALLE FACTURA</div>
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
<script src="js/facturas.js"></script>
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