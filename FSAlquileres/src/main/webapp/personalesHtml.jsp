<%@include file="header.jsp"%>
<style>
    #resultado {
        table-layout: auto; /* Permite que las columnas ajusten su ancho autom�ticamente */
        width: 100%; /* Hace que la tabla use el ancho completo del contenedor */
    }
    #resultado td, #resultado th {
        white-space: nowrap; /* Evita que el texto se ajuste autom�ticamente a nuevas l�neas */
        word-break: break-all; /* Fuerza la divisi�n de palabras largas para evitar deformaciones */
        overflow: hidden; /* Oculta el texto desbordante */
        text-overflow: ellipsis; /* A�ade puntos suspensivos al texto desbordante */
    }
    .table-responsive {
        overflow-x: auto; /* Asegura que haya un desplazamiento horizontal si es necesario */
    }
</style>
<!-- Content wrapper scroll start -->
<div class="content-wrapper-scroll">
    <!-- Content wrapper start -->
    <div class="content-wrapper">
        <!-- Row start -->

        <div class="row gutters">
            <div class="col-xxl-6 col-sm-12 col-12">
                <div class="card gradient-dark-grey">
                    <div class="custom-btn-group flex-lg-row">
                    </div>
                    <div class="card-header">
                        <div class="card-title">PERSONALES <button type="button" class="badge rounded-pill gradient-blue" onclick="window.open('jsp/reportePersonales.jsp', '_blank')">
                                REPORTE
                            </button></div> 

                    </div>
                    <div class="card-body">

                        <form action="#" id="form" method="POST">
                            <input type="hidden" id="listar" name="listar" value="cargar">
                            <input type="hidden" id="pk" name="pk">                                
                            <div class="mb-3 control-dark">                                
                                <span class="blanco">NOMBRE/S: </span></span><span style="color: red;cursor: pointer;" title="OBLIGATORIO" >*</span><input type="text" autofocus="" class="form-control" id="per_nombre" name="per_nombre" placeholder="Ingrese nombre..."/>
                            </div>
                            <div class="mb-3 control-dark">                                            
                                <span class="blanco">APELLIDO/S: </span></span><span style="color: red;cursor: pointer;" title="OBLIGATORIO" >*</span><input type="text" class="form-control" id="per_apellido" name="per_apellido" placeholder="Ingrese apellido..."/>
                            </div>
                            <div class="mb-3 control-dark">                                            
                                <span class="blanco">C.I.: </span></span><span style="color: red;cursor: pointer;" title="OBLIGATORIO" >*</span><input type="text" class="form-control" id="per_ci" name="per_ci" placeholder="Ingrese CI..." onInput="validarSoloNumeros(this)"/>
                            </div>
                            <div class="mb-3 control-dark">                                            
                                <span class="blanco">TELEFONO: </span></span><span style="color: red;cursor: pointer;" title="OBLIGATORIO" >*</span><input type="text" class="form-control" id="per_telefono" name="per_telefono" placeholder="Ingrese telefono..." onInput="validarSoloNumeros(this)"/>
                            </div>                            
                            <button type="button" class="btn btn-dark" id="boton" name="boton">AGREGAR</button> <button type="button" class="btn btn-danger" id="cancelar" name="cancelar">CANCELAR</button>
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
                        ELIMINAR PERSONAL
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                            aria-label="Close"></button>
                </div>
                <input type="hidden" id="pkdel" name="pkdel">
                <div class="modal-body">�Est� seguro que desea eliminar el registro?</div>
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

<script src="js/personales.js"></script>
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
