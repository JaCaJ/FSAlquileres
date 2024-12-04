<%@include file="header.jsp"%>

<!-- Content wrapper scroll start -->
<div class="content-wrapper-scroll">
    <!-- Content wrapper start -->
    <div class="content-wrapper">
        <!-- Row start -->

        <div class="row gutters">
            <div class="col-xxl-6 col-sm-12 col-12">
                <div class="card gradient-dark-grey">
                    <div class="card-header">
                        <div class="card-title">CLIENTES <button type="button" class="badge rounded-pill gradient-blue" onclick="window.open('jsp/reporteClientes.jsp', '_blank')">
                                REPORTE
                            </button></div>
                    </div>
                    <div class="card-body">

                        <form action="#" id="form" method="POST">
                            <input type="hidden" id="listar" name="listar" value="cargar">
                            <input type="hidden" id="pk" name="pk">                                
                            <div class="mb-3 control-dark">                                
                                <span class="blanco">NOMBRE/S: </span><span style="color: red;cursor: pointer;" title="OBLIGATORIO" >*</span><input type="text" autofocus="" class="form-control" id="cli_nombre" name="cli_nombre" placeholder="Ingrese nombre..." maxlength="49" title="Cantidad máxima de caracteres 49"/>
                            </div>
                            <div class="mb-3 control-dark">                                            
                                <span class="blanco">APELLIDO/S: </span><input type="text" class="form-control" id="cli_apellido" name="cli_apellido" placeholder="Ingrese apellido..." maxlength="49" title="Cantidad máxima de caracteres 49"/>
                            </div>
                            <div class="mb-3 control-dark">                                            
                                <span class="blanco">C.I.: </span><span style="color: red;cursor: pointer;" title="OBLIGATORIO" >*</span><input type="text" class="form-control" id="cli_ci" name="cli_ci" placeholder="Ingrese CI..." onInput="validarSoloNumeros(this)" maxlength="18" title="Cantidad máxima de caracteres 18"/>
                            </div>
                            <div class="mb-3 control-dark">                                            
                                <span class="blanco">TELEFONO: </span><span style="color: red;cursor: pointer;" title="OBLIGATORIO" >*</span><input type="text" class="form-control" id="cli_telefono" name="cli_telefono" placeholder="Ingrese telefono..." onInput="validarSoloNumeros(this)" maxlength="18" title="Cantidad máxima de caracteres 18"/>
                            </div>
                            <div class="mb-3 control-dark">                                            
                                <span class="blanco">DIRECCION GOOGLE MAPS: </span><input type="text" class="form-control" id="cli_direccion_maps" name="cli_direccion_maps" placeholder="Ingrese dirección..." maxlength="29" title="Cantidad máxima de caracteres 29" />
                            </div>
                            <div class="mb-3 control-dark">                                            
                                <span class="blanco">REFERENCIA DIRECCION: </span><input type="text" class="form-control" id="cli_referencia_direccion" name="cli_referencia_direccion" placeholder="Ingrese referencia dirección..." maxlength="149" title="Cantidad máxima de caracteres 149"/>
                            </div>
                            <button type="button" class="btn btn-success" id="boton" name="boton">AGREGAR</button> <button type="button" class="btn btn-danger" id="cancelar" name="cancelar">CANCELAR</button>
                        </form>  
                    </div>
                </div>
                <!-- Mensaje de tipo toast -->
                <div class="position-fixed top-0 end-0 toast bg-primary show" role="alert" aria-live="assertive" aria-atomic="true">
                    <div class="toast-body show" id="mensaje"></div>
                </div>
                <!-- Row start -->
                <div class="row gutters">					
                    <!-- Row start -->
                    <div class="col-sm-12 col-12">
                        <div class="card gradient-dark-grey">
                            <div class="card-body">
                                <div class="table-responsive">
                                    
                                    <table class="table table-bordered m-0 table-hover" id="resultado">
                                        <thead>
                                            <tr>
                                                <th>ACCIONES</th>
                                                <th>ID</th>
                                                <th>NOMBRE</th>
                                                <th>APELLIDO</th>
                                                <th>C.I.</th>
                                                <th>TELEFONO</th>
                                                <th>DIR. GOOGLE MAPS</th>
                                                <th>REFERENCIA DIRECCION</th>
                                                
                                            </tr>
                                        </thead>
                                        <tbody>

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
                        ELIMINAR CLIENTE
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                            aria-label="Close"></button>
                </div>
                <input type="hidden" id="pkdel" name="pkdel">
                <div class="modal-body">¿Está seguro que desea eliminar el registro?</div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-dark" data-bs-dismiss="modal">
                        NO
                    </button>
                    <button type="button" class="btn btn-success" data-bs-dismiss="modal" id="eliminarreg">
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


<!-- Main Js Required -->

<script src="js/clientes.js"></script>
<script>
                            function validarSoloNumeros(input) {
                                var re = /^[0-9]*$/i;
                                let msg = input.value;
                                if (!(msg.match(re) !== null)) {
                                    input.value = msg.slice(0, msg.length - 1);
                                }
                            }
</script>
<%@include file="footer.jsp"%>
