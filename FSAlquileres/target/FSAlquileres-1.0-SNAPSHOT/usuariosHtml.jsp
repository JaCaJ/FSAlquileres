<%@include file="header.jsp"%>
<style>
    #resultado {
        table-layout: auto; /* Permite que las columnas ajusten su ancho automáticamente */
        width: 100%; /* Hace que la tabla use el ancho completo del contenedor */
    }
    #resultado td, #resultado th {
        white-space: nowrap; /* Evita que el texto se ajuste automáticamente a nuevas líneas */
        word-break: break-all; /* Fuerza la división de palabras largas para evitar deformaciones */
        overflow: hidden; /* Oculta el texto desbordante */
        text-overflow: ellipsis; /* Añade puntos suspensivos al texto desbordante */
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
                    <div class="card-header">
                        <div class="card-title">USUARIOS <button type="button" class="badge rounded-pill gradient-blue" onclick="window.open('jsp/reporteUsuarios.jsp', '_blank')">
                                REPORTE
                            </button></div>
                    </div>
                    <div class="card-body">
                        <form action="#" id="form" method="POST">
                            <input type="hidden" id="listar" name="listar" value="cargar">
                            <input type="hidden" id="pk" name="pk">                                
                            <div class="mb-3 control-dark">                                
                                <span class="blanco">NICK: </span></span><span style="color: red;cursor: pointer;" title="OBLIGATORIO" >*</span><input type="text" autofocus="" class="form-control" id="usu_nick" name="usu_nick" placeholder="Ingrese nick del usuario..."/>
                            </div>
                            <div class="mb-3 control-dark">                                            
                                <span class="blanco">CLAVE: </span></span><span style="color: red;cursor: pointer;" title="OBLIGATORIO" >*</span><input type="password" class="form-control" id="usu_clave" name="usu_clave" placeholder="Ingrese clave del usuario..."/>
                            </div>
                            <div class="mb-3 control-dark">
                                <span class="blanco">ROL: </span></span><span style="color: red;cursor: pointer;" title="OBLIGATORIO" >*</span>
                                <select class="form-select" aria-label="Default select example" id="usu_rol" name="usu_rol">
                                    <option selected value="0">SELECCIONE UN ROL</option>
                                    <option value="ADMINISTRADOR">ADMINISTRADOR</option>
                                    <option value="AYUDANTE">AYUDANTE</option>
                                </select>
                            </div>
                            <div class="mb-3 control-dark">
                                <input type="hidden" id="fk" name="fk" value="">
                                <span class="blanco">PERSONAL: </span></span><span style="color: red;cursor: pointer;" title="OBLIGATORIO" >*</span>
                                <select class="form-select" name="selectPersonal" id="selectPersonal" onchange="dividirpersonal(this.value)">
                                </select>

                            </div>
                            <button type="button" class="btn btn-dark" id="boton" name="boton">AGREGAR</button>
                            <button type="button" class="btn btn-danger" id="cancelar" name="cancelar">CANCELAR</button>
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
                                    <table class="table table-bordered m-0" id="resultado">
                                        <thead>
                                            <tr>
                                                <th>ACCIONES</th>
                                                <th>ID</th>
                                                <th>NICK</th>
                                                <th>ROL</th>
                                                <th>PERSONAL</th>
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
                        ELIMINAR USUARIO
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

<script src="js/usuarios.js"></script>
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
