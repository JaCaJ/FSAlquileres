
<!-- App Footer start -->
<div class="app-footer">
    <span>© FS ALQUILERES</span>
</div>
<!-- App footer end -->

</div>
<!-- Content wrapper scroll end -->

</div>
<!-- *************
        ************ Main container end *************
************* -->
</div>
<!-- Modal cambio de contraseña -->
<!-- estilo para no coincidencia de contraseñas-->
<style>
        .error {
            border-color: red;
        }
    </style>
<div class="modal modal-dark fade" id="scrollable" data-bs-backdrop="static" data-bs-keyboard="false"
     tabindex="-1" aria-labelledby="scrollableLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="scrollableLabel">
                    CAMBIAR CONTRASEÑA
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>
                    ¿ESTÁ SEGURO QUE DESEA CAMBIAR LA CONTRASEÑA?
                </p>
                <div class="row gutters">
                    <div class="col-sm-12 col-12">
                        <div class="mb-3 control-dark">
                            <input type="hidden" id="listar" name="listar" value="cambio">
                            <label class="form-label">CONTRASEÑA ACTUAL
                                <span class="text-red">*</span></label>
                                <input type="password" class="form-control" id="cv" name="cv" placeholder="Ingrese su contraseña actual." oninput="validarContrasena()"/>
                        </div>
                        <div id="mensajeContrasena1" name="mensajeContrasena1"></div>
                        <div class="mb-3 control-dark">
                            <label class="form-label">NUEVA CONTRASEÑA
                                <span class="text-red">*</span></label>
                                <input type="password" class="form-control" id="cn" name="cn" placeholder="Ingrese su nueva contraseña." oninput="validarContrasena()"/>
                        </div>
                        <div class="mb-3 control-dark">
                            <label class="form-label">REPITA SU NUEVA CONTRASEÑA
                                <span class="text-red">*</span></label>
                                <input type="password" class="form-control" id="vc" name="vc" placeholder="Repita su nueva contraseña." oninput="validarContrasena()"/>
                                <div id="mensajeContrasena2" name="mensajeContrasena2"></div>
                        </div>
                    </div>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-dark" data-bs-dismiss="modal" id="no">
                    NO
                </button>
                <button type="button" class="btn btn-success" data-bs-dismiss="modal" id="cambioClave">
                    SÍ
                </button>
            </div>
        </div>
    </div>
</div>
<!-- Page wrapper end -->

<!-- *************
        ************ Required JavaScript Files *************
************* -->
<!-- Required jQuery first, then Bootstrap Bundle JS -->
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/bootstrap.bundle.min.js"></script>
<script src="assets/js/modernizr.js"></script>
<script src="assets/js/moment.js"></script>

<!-- *************
        ************ Vendor Js Files *************
************* -->

<!-- Overlay Scroll JS -->
<script src="assets/vendor/overlay-scroll/jquery.overlayScrollbars.min.js"></script>
<script src="assets/vendor/overlay-scroll/custom-scrollbar.js"></script>

<!-- Apex Charts -->
<script src="assets/vendor/apex/apexcharts.min.js"></script>
<script src="assets/vendor/apex/custom/home2/byDeviceGraph.js"></script>
<script src="assets/vendor/apex/custom/home2/earningsGraph.js"></script>
<script src="assets/vendor/apex/custom/home2/salesGraph.js"></script>
<script src="assets/vendor/apex/custom/home2/sparklineGraphs.js"></script>

<!-- Main Js Required -->
<script src="assets/js/main.js"></script>                
<script src="js/contrasena.js"></script>
<script src="js/caja.js"></script>
</body>
</html>
<% }%>