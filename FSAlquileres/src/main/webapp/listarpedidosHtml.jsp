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
                <h4>Listar Pedidos</h4>
                <!-- Row start -->
                <div class="col-sm-12 col-12">
                    <div class="custom-btn-group flex-lg-row">
                        <button type="button" class="btn btn-primary" onclick="location.href = 'pedidos.jsp'">
                            Nuevo Pedido
                        </button>
                        <button type="button" class="btn btn-success" onclick="window.open('jsp/reportePedidos.jsp', '_blank')">
                            Reportes
                        </button>
                    </div>
                    <div class="card gradient-dark-grey">

                        <div class="card-body">
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
                    </div>
                </div>
                <!-- Row end -->
            </div>
        </div>
        <!-- Row end -->
    </div>
</div>
<!-- Content wrapper end -->

<!-- Modal anular pedido -->
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
            <div class="modal-body">¿Está seguro que desea anular el pedido?</div>
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

<!-- Modal entregar pedido -->
<div class="modal modal-dark fade" id="entregar" tabindex="-1" aria-labelledby="modalDarkLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalDarkLabel">
                    ENTREGAR PEDIDO
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>
            <input type="hidden" id="auxEntregar" name="auxEntregar">
            <div class="modal-body blanco">¿Cambiar estado a entregado?</div>
            <div class="modal-footer">
                <button type="button" class="btn btn-dark" data-bs-dismiss="modal">
                    NO
                </button>
                <button type="button" class="btn btn-success" data-bs-dismiss="modal" onclick="entregar($('#auxEntregar').val());" >
                    Si
                </button>
            </div>
        </div>
    </div>
</div>

<button id="modalTrigger" type="hidden" class="d-none" data-bs-toggle="modal" data-bs-target="#scrollable"></button>
<!-- Modal 3 -->
<div class="modal modal-dark fade" id="scrollable" data-bs-backdrop="static" data-bs-keyboard="false"
     tabindex="-1" aria-labelledby="scrollableLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="scrollableLabel">
                    DEVOLVER PEDIDOS
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <h6 class="blanco">Datos del pedido:</h6>
                <b class="blanco">ID: </b> <span id="idd" class="blanco"></span>&emsp;
                <b class="blanco">Cliente: </b><span id="cliente" class="blanco"></span>
                <br>
                <b class="blanco">Fecha: </b><span id="fecha" class="blanco"></span>&emsp;
                <b class="blanco">Total: </b><span id="total" class="blanco"></span><br><br>
                <div class="product-block">
                    <div class="product-body">
                        <div class="row gutters">
                            <div class="col-sm-6 col-12">
                                <div class="mb-3 control-dark">
                                    <div id="enviados"></div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-12">
                                <div class="mb-3 control-dark" >
                                    <div class="mb-3 control-dark">
                                        <input type="hidden" id="listar" name="listar" value="devolverpedido"/>
                                        <form action="#" id="form" method="POST" role="form">
                                        <div id="recibidos"></div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-dark" data-bs-dismiss="modal">
                    CANCELAR
                </button>
                <button type="button" class="btn btn-success" data-bs-dismiss="modal" id="btn_devolver" name="btn_devolver">
                    DEVOLVER
                </button>
            </div>
        </div>
    </div>
</form>
</div>
<!-- Required jQuery first, then Bootstrap Bundle JS -->
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/bootstrap.bundle.min.js"></script>
<script src="assets/js/modernizr.js"></script>
<script src="assets/js/moment.js"></script>
<script src="js/listarpedidos.js"></script>
<%@include file="footer.jsp"%>