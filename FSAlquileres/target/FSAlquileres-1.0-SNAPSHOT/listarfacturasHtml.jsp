<%@include file="header.jsp"%>

<!-- Content wrapper scroll start -->
<div class="content-wrapper-scroll">
    <!-- Content wrapper start -->
    <div class="content-wrapper">
        <!-- Row start -->

        <div class="row gutters">
            <div class="col-xxl-6 col-sm-12 col-12">
                <div class="card gradient-dark-grey">
                </div>
                <div class="toast-body show" id="mensaje"></div>
            </div>
            <!-- Row start -->
            <div class="row gutters">
                <h4>Listar Facturas</h4>
                <!-- Row start -->
                <div class="col-sm-12 col-12">
                    <div class="custom-btn-group flex-lg-row">
                        <button type="button" class="btn btn-primary" onclick="location.href = 'facturasHTML.jsp'">
                            Nueva factura
                        </button>
                        <button type="button" id="btn_pedidos" name="btn_pedidos" class="btn btn-white" data-bs-toggle="modal" data-bs-target="#modalLg">
                            Pedidos
                        </button>
                        <button type="button" class="btn btn-success" onclick="window.open('jsp/reportePedidos.jsp', '_blank')">
                            Reportes
                        </button>
                    </div>
                    <br>
                    <div class="card gradient-dark-grey">

                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered m-0" >
                                    <thead>
                                        <tr>
                                            <th>ACCION</th>
                                            <th>FACTURA N°</th>
                                            <th>CLIENTE</th>
                                            <th>TOTAL</th>                                            
                                            <th>ESTADO</th>                                            
                                        </tr>
                                    </thead>
                                    <tbody id="facturas">

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
                <!-- Row end -->
            </div>
        </div>
        <!-- Row end -->
    </div>
</div>
<!-- Content wrapper end -->

<!-- Modal Dark -->
<div class="modal modal-dark fade" id="modalDark" tabindex="-1" aria-labelledby="modalDarkLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalDarkLabel">
                    ANULAR PEDIDO
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>
            <input type="hidden" id="idpk" name="idpk">
            <div class="modal-body">¿Está seguro que desea eliminar el registro?</div>
            <div class="modal-footer">
                <button type="button" class="btn btn-dark" data-bs-dismiss="modal">
                    NO
                </button>
                <button type="button" class="btn btn-success" data-bs-dismiss="modal" id="eliminar-registro-pedido" name="eliminar-registro-pedido">
                    Si
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Modal anular factura -->
<div class="modal modal-dark fade" id="modalDark3" tabindex="-1" aria-labelledby="modalDarkLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalDarkLabel">
                    ANULAR FACTURA
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>
            <input type="hidden" id="idfactura" name="idfactura">
            <div class="modal-body blanco">¿Está seguro que desea ANULAR la factura?</div>
            <div class="modal-footer">
                <button type="button" class="btn btn-dark" data-bs-dismiss="modal">
                    NO
                </button>
                <button type="button" class="btn btn-success" data-bs-dismiss="modal" id="anular-factura" name="anular-factura">
                    Si
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Modal 7 -->
<div class="modal modal-dark fade" id="modalLg" tabindex="-1" aria-labelledby="modalLgLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalDarkLabel">
                    Generar factura de pedido.
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- <h6 class="modal-title" id="modalDarkLabel">Estado de caja</h6> -->
                <div class="table-responsive">
                    <table class="table table-bordered m-0" >
                        <thead>
                            <tr>
                                <th>ACCION</th>
                                <th>FECHA</th>
                                <th>CLIENTE</th>
                                <th>ESTADO</th>
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
            <div class="modal-footer">
                <button type="button" class="btn btn-dark" data-bs-dismiss="modal">
                    CANCELAR
                </button>
                <button type="button" class="btn btn-success" data-bs-dismiss="modal">
                    CERRAR
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Required jQuery first, then Bootstrap Bundle JS -->
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/bootstrap.bundle.min.js"></script>
<script src="assets/js/modernizr.js"></script>
<script src="assets/js/moment.js"></script>

<script src="js/listarfacturas.js"></script>
<%@include file="footer.jsp"%>