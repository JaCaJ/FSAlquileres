<%@include file="header.jsp"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page import="java.math.BigInteger"%>
<%@page import="java.security.MessageDigest"%>
<div class="content-wrapper">
    <div class="row gutters">
        <div class="col-sm-12 col-12">
            <div class="card gradient-dark-grey">
                <div class="card-header">
                    <div class="card-title">INFORME DE PEDIDOS</div>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-sm-12 col-12">
                            <div class="product-block">
                                <!--<div class="product-title">General Information</div>-->
                                <div class="product-body">
                                    <div class="row gutters">
                                        <div class="col-sm-3 col-3">
                                            <div class="mb-3 control-dark">
                                                <form action="#" id="form" method="POST" role="form">
                                                    <input type="hidden" id="listar" name="listar" value="cargar"/>
                                                    <!-- Field wrapper start -->
                                                    <div class="mb-3 control-dark">
                                                        <div class="form-label">FECHA DESDE<span class="text-red"> *</span></div>
                                                        <input class="form-control datepicker-input input-group" 
                                                               type="date" name="fecha_desde" id="fecha_desde">
                                                    </div>
                                                    <div class="mb-3 control-dark">
                                                        <label class="form-label">USUARIO</label> 
                                                        <input type="hidden" id="usuariofk" name="usuariofk" value="0">
                                                        <select class="form-select" name="selectUsuario" id="selectUsuario" onchange="dividirusuario(this.value)">
                                                        </select>
                                                    </div>
                                                    <!-- Field wrapper end -->
                                            </div>
                                        </div>
                                        <div class="col-sm-3 col-3">
                                            <div class="mb-3 control-dark">
                                                <div class="form-label">FECHA HASTA<span class="text-red"> *</span></div>
                                                <input class="form-control datepicker-input input-group" 
                                                       type="date" name="fecha_hasta" id="fecha_hasta">
                                            </div>
                                            <div class="mb-3 control-dark">
                                                    <label class="form-label">CLIENTE</label> 
                                                <select class="form-select" name="selectCliente" id="selectCliente" onchange="dividircliente(this.value)">
                                                </select>
                                                <input type="hidden" id="clientefk" name="clientefk" value="0">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</form>
        <div class="col-sm-12 col-12">
            <div class="custom-btn-group flex-end">
                <button type="button" class="btn btn-light" id="btn-cancelar">
                    Cancelar
                </button>
                <button type="button" class="btn btn-success" id="btn-gi" name="btn-gi" onclick="abrirReporte($('#fecha_desde').val(), $('#fecha_hasta').val(), $('#usuariofk').val(), $('#clientefk').val());">
                    GENERAR INFORME
                </button>
            </div>
        </div>
    </div>
</div>
</div>
</div>
</div>
<!-- Row end -->

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
<script src="js/dePedido.js"></script>
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

