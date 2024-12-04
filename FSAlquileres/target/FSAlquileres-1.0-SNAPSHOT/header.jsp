<!DOCTYPE html>
<%
    HttpSession sesion = request.getSession();
    if (sesion.getAttribute("logueado") == null || sesion.getAttribute("logueado").equals("0")) {
%>
<script>alert('¡Ud. debe de identificarse!');location.href = 'index.jsp'</script>
<%
} else {

%>
<html lang="es">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <!-- Meta -->
        <meta name="description" content="FSALQUILERES" />
        <meta name="author" content="JORGE CARDOZO" />
        <link rel="canonical" href="https://www.bootstrap.gallery/">
        <meta property="og:url" content="https://www.bootstrap.gallery">
        <meta property="og:title" content="BIENVENID@">
        <meta property="og:description" content="Marketplace for Bootstrap Admin Dashboards">
        <meta property="og:type" content="Website">
        <meta property="og:site_name" content="Bootstrap Gallery">
        <link rel="shortcut icon" href="assets/images/favicon.svg" />
        <!-- Title -->
        <title>FSALQUILERES</title>
        <!--************ Common Css Files ************ -->
        <!-- Animated css -->
        <link rel="stylesheet" href="assets/css/animate.css" />
        <!-- Icomoon Font Icons css -->
        <link rel="stylesheet" href="assets/fonts/icomoon/icomoon.css" />
        <!-- Main css -->
        <link rel="stylesheet" href="css/myStyles.css" />
        <!-- Modified css -->
        <link rel="stylesheet" href="assets/css/main.min.css" />
        <!-- ************* Vendor Css Files ************ -->
        <!-- Scrollbar CSS -->
        <link rel="stylesheet" href="assets/vendor/overlay-scroll/OverlayScrollbars.min.css" />
    </head>
    <body>
        <input type="hidden" id="usu" name="usu" value="<% out.print(sesion.getAttribute("id")); %>">
        <!-- Page wrapper start -->
        <div class="page-wrapper">
            <!-- Sidebar wrapper start -->
            <nav class="sidebar-wrapper">
                <!-- Sidebar brand starts -->
                <div class="sidebar-brand">
                    <a href="dashboard.jsp" class="logo">
                        <img src="reportes/logo recrearte.jpg" alt="EVENTOS RECREARTE" />
                    </a>
                </div>
                <!-- Sidebar menu starts -->
                <div class="sidebarMenuScroll">
                    <div class="sidebar-menu">
                        <ul>
                            <% if (sesion.getAttribute("rol").equals("ADMINISTRADOR")) {%>
                            <li class="sidebar-dropdown">
                                <a>
                                    <i class="icon-insert_chart_outlined gradient-orange"></i>
                                    <span class="menu-text "><b>ABMS</b></span>
                                </a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li>
                                            <a href="clientes.jsp">CLIENTES</a>
                                        </li>
                                        <li>
                                            <a href="personalesHtml.jsp">PERSONALES</a>
                                        </li>
                                        <li>
                                            <a href="usuariosHtml.jsp">USUARIOS</a>
                                        </li>
                                        <li>
                                            <a href="serviciosHtml.jsp">SERVICIOS</a>
                                        </li>
                                        <li>
                                            <a href="articuloTipo.jsp">TIPO DE ARTICULO</a>
                                        </li>
                                        <li>
                                            <a href="articulosHtml.jsp">ARTICULOS</a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <% } %>
                            <li class="sidebar-dropdown">
                                <a>
                                    <i class="icon-add_circle_outline gradient-green"></i>
                                    <span class="menu-text"><b>PEDIDOS</b></span>
                                </a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li>
                                            <a href="listarpedidosHtml.jsp">Generar pedido</a>
                                        </li>

                                    </ul>
                                </div>
                            </li>
                            <li class="sidebar-dropdown">
                                <a>
                                    <i class="icon-list_alt gradient-teal"></i>
                                    <span class="menu-text"><b>FACTURACION</b></span>
                                </a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li>
                                            <a href="listarfacturasHtml.jsp">Generar Factura</a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="sidebar-dropdown">
                                <a>
                                    <i class="icon-pageview gradient-brick"></i>
                                    <span class="menu-text"><b>INFORMES</b></span>
                                </a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li>
                                            <a href="dePedidoHTML.jsp">De pedidos</a>
                                        </li>
                                        <li>
                                            <a href="deFacturasHTML.jsp">De facturas</a>
                                        </li>
                                        <li>
                                            <a href="deCajaHTML.jsp">De caja</a>
                                        </li>
                                    </ul>
                                </div>
                            </li>

                        </ul>
                    </div>
                </div>
                <!-- Sidebar menu ends -->

            </nav>
            <!-- Sidebar wrapper end -->

            <!-- *************
                    ************ Main container start *************
            ************* -->
            <div class="main-container">

                <!-- Page header starts -->
                <div class="page-header">

                    <!-- Breadcrumb container start -->
                    <div class="breadcrumb-container">

                        <!-- Toggle sidebar start -->
                        <div class="toggle-sidebar" id="toggle-sidebar">
                            <i class="icon-menu"></i>
                        </div>
                        <!-- Toggle sidebar end -->


                        <!-- App brand start -->
                        <div class="app-brand-sm">
                            <a href="dashboard.jsp.jsp" class="d-xl-none d-lg-block">
                                <img src="assets/images/logo.svg" class="logo" alt="Bootstrap Gallery">
                            </a>
                        </div>
                        <!-- App brand end -->

                        <!-- Breadcrumb start -->
                        <ol class="breadcrumb d-xl-flex d-none">
                            <li class="breadcrumb-item">
                                <i class="icon-house_siding"></i>
                                <a href="dashboard.jsp.jsp">Home</a>
                            </li>
                            <li class="breadcrumb-item breadcrumb-active" aria-current="page">
                                Inicio
                            </li>
                        </ol>
                        <!-- Breadcrumb end -->

                    </div>
                    <!-- Breadcrumb container end -->

                    <!-- Header actions ccontainer start -->
                    <div class="header-actions-container">
                        <!-- Header actions start -->
                        <ul class="header-actions">
                            <li class="dropdown">
                                <a href="#" id="bookmarks" data-toggle="dropdown" aria-haspopup="true">
                                    <i class="icon-attach_money"></i>
                                </a>
                                <div class="dropdown-menu dropdown-menu-end md" aria-labelledby="userSettings">
                                    <ul class="header-notifications">
                                        <li class="gradient-grey">
                                            <a href="#">

                                                <div class="details">
                                                    <div class="user-title">Estado de caja:</div>
                                                    <div class="noti-details" id="estadocaja">
                                                    </div>
                                                </div>
                                            </a>
                                        </li>
                                    </ul>

                                    <div class="header-profile-actions">
                                        <a href="#" class="gradient-green" data-bs-toggle="modal" data-bs-target="#modalCaja">ABRIR</a>
                                        <a href="#" class="gradient-red" data-bs-toggle="modal" data-bs-target="#modalDark2">CERRAR</a>
                                    </div>
                                </div>
                            </li>
                            
                            <li class="dropdown">
                                <a href="#" id="userSettings" class="user-settings" data-toggle="dropdown" aria-haspopup="true">
                                    <span class="user-name d-none d-md-block"><% out.print(sesion.getAttribute("user")); %></span>
                                    <span class="avatar">
                                        <img src="assets/images/user.jpg" alt="Admin Themes" />
                                        <span class="status online"></span>
                                    </span>
                                </a>
                                <div class="dropdown-menu dropdown-menu-end md" aria-labelledby="userSettings">
                                    <div class="header-profile-avatar">
                                        <img src="assets/images/user.jpg" alt="Admin Themes" />
                                    </div>
                                    <div class="header-profile-block">
                                        <h5><% out.print(sesion.getAttribute("user")); %></h5>
                                        <p><% out.print(sesion.getAttribute("rol"));%></p>
                                    </div>
                                    <div class="header-profile-actions">
                                        <a href="dashboard.html" class="gradient-blue"><i class="icon-arrow_back"></i>Dashboard</a>
                                        <a class="gradient-green text-center iHover" data-bs-toggle="modal" data-bs-target="#scrollable"><i class="icon-edit_road"></i>Cambiar contraseña</a>
                                        <a href="jsp/logout.jsp" class="gradient-red"><i class="icon-power_settings_new"></i>Logout</a>
                                    </div>
                                </div>
                            </li>
                        </ul>
                        <!-- Header actions end -->

                    </div>
                    <!-- Header actions ccontainer end -->

                </div>
                <!-- Page header ends -->
                <!-- Modal Dark -->
                <div class="modal modal-dark fade" id="modalCaja" tabindex="-1" aria-labelledby="modalDarkLabel"
                     aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="modalDarkLabel" on>
                                    ABRIR CAJA
                                </h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="mb-3 control-dark">
                                    <div class="form-label">MONTO INICIAL<span class="text-red"> *</span></div>
                                    <input type="text" class="form-control" id="montoi" name="montoi" oninput="validarSoloNumeros(this)" placeholder="Inserte monto inicial." value="0"/>
                                    
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-dark" data-bs-dismiss="modal">
                                    CANCELAR
                                </button>
                                <button type="button" class="btn btn-success" data-bs-dismiss="modal" id="abrircaja" name="abrircaja">
                                    ACEPTAR
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal Dark 2-->
                <div class="modal modal-dark fade" id="modalDark2" tabindex="-1" aria-labelledby="modalDarkLabel"
                     aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="modalDarkLabel" on>
                                    CERRAR CAJA
                                </h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <h4 class="blanco">¿Está seguro de cerrar la caja?</h4>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-dark" data-bs-dismiss="modal">
                                    CANCELAR
                                </button>
                                <button type="button" class="btn btn-success" data-bs-dismiss="modal" id="cerrarcaja" name="cerrarcaja">
                                    ACEPTAR
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <script>
                    function validarSoloNumeros(input) {
                        var re = /^[0-9]*$/;
                        let msg = input.value;
                        if (!(msg.match(re) !== null)) {
                            input.value = msg.slice(0, msg.length - 1);
                        }
                    }

                </script>