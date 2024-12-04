<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@include file="conexion.jsp"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%    Statement st = null;
    ResultSet rs = null;
    st = conn.createStatement();
    Integer diferencia_pedido = null;
    Integer contador_faltantes = 0;
    // Obtener fecha actual y formatearla
    Date fechaActual = new Date();
    SimpleDateFormat formateadorFecha = new SimpleDateFormat("dd-MM-yyyy");
    String fechaFormateada = formateadorFecha.format(fechaActual);
    String nro_factura = null;
    Integer total_factura = null;
    Integer id_pedido = null;

    if (request.getParameter("listar").equals("listar")) {
        try {
            rs = st.executeQuery("SELECT * FROM pedidos p inner join clientes c on p.ped_cli_id_fk=c.cli_id where ped_estado='FINALIZADO' OR ped_estado='COBRADO' OR ped_estado='FACTURADO' ORDER BY ped_id DESC;");
            while (rs.next()) {
%>
<tr>
    <td> 
        <i class="icon-delete_outline text-red iHover" title="Anular registro" data-bs-toggle="modal" data-bs-target="#modalDark" onclick="$('#idpk').val(<% out.print(rs.getString(1));%>)">
        </i>
        <i class="icon-picture_as_pdf text-white iHover" title="Generar comprobante" onclick="abrirReporte('<%= rs.getString(1)%>', '<%= rs.getString(8)%>');">
        </i>
        <%if (rs.getString(12).equals("ENTREGADO")) {%>
        <i class="icon-library_add_check text-green iHover" title="Devolver artículos" data-bs-toggle="modal"
           data-bs-target="#scrollable" onclick="cargarcabecera('<%= rs.getString(1)%>');" id="<%out.print(rs.getString(1));%>">
        </i>
        <%}%>
        <%if (rs.getString(12).equals(" ")) {%>
        <i class="icon-next_plan text-green iHover" title="Entregar artículos" data-bs-toggle="modal"
           data-bs-target="#entregar" onclick="$('#auxEntregar').val('<%= rs.getInt(1)%>');">

        </i>
        <%}%>

    </td>
    <td><% out.print(rs.getString(2)); %></td>
    <td><% out.print(rs.getString(14)); %> <% out.print(rs.getString(15)); %> <% out.print(rs.getString(16)); %> </td>
    <td><% out.print(rs.getString(9)); %> <%if (!rs.getString(12).equals(" ")) {%> Y <% out.print(rs.getString(12)); %> <%}%></td>
    <td><% out.print(rs.getString(8)); %></td>
</tr>
<%
        }
        rs.close();
        st.close();
    } catch (Exception e) {
        out.println("error PSQL" + e);
    }
} else if (request.getParameter("listar").equals("anularpedido")) {
    try {
        st.executeUpdate("update pedidos set ped_estado='ANULADO' where ped_id='" + request.getParameter("pkd") + "'");
        st.close();
    } catch (Exception e) {
    }
} else if (request.getParameter("listar").equals("entregar")) {
    String aux7 = request.getParameter("idpedido");
    int idpedido = Integer.parseInt(aux7);
    try {
        st.executeUpdate("update pedidos set entregado='ENTREGADO' where ped_id='" + idpedido + "'");
        st.close();
        out.print("PEDIDO ENTREGADO");
    } catch (Exception e) {
    }
} else if (request.getParameter("listar").equals("cargarcabecera")) {
    String aux3 = request.getParameter("idpedido");
    int idpedido = Integer.parseInt(aux3);
    try {
        st = conn.createStatement();
        String cab[] = new String[]{};
        rs = st.executeQuery("SELECT * FROM pedidos p inner join clientes c on p.ped_cli_id_fk=c.cli_id where ped_id='" + idpedido + "';");
        rs.next();
        cab = new String[]{rs.getString(1), rs.getString(2), rs.getString(14), rs.getString(15), rs.getString(16), rs.getString(8)};
        Gson gson = new Gson();
        out.print(gson.toJson(cab));

        rs.close();
        st.close();
    } catch (Exception e) {
        out.println("error PSQL" + e);
    }
} else if (request.getParameter("listar").equals("listarenviados")) {
    try {
        String idpedido = request.getParameter("idpedido");
        rs = st.executeQuery("select dp.det_ped_id, ser.ser_descripcion, art.art_nombre, dp.det_ped_precio_unitario, dp.det_ped_cantidad_pedido, ati.articulo_tipo_descripcion, ser.ser_id, art.art_id from detalle_pedido dp, articulos art, servicios ser, articulo_tipo ati where dp.det_ped_art_id_fk = art.art_id and dp.det_ped_ser_id_fk = ser.ser_id and art.articulo_tipo_id = ati.articulo_tipo_id and dp.det_ped_ped_id_fk ='" + idpedido + "' ORDER BY dp.det_ped_id ASC;");
        while (rs.next()) {
%>
<div class="mb-3 control-dark">
    <div class="form-label"><%if (rs.getString(3).equals("")) {%><span class="blanco" ><%out.print(rs.getString(2));%><%}%><%if (rs.getString(2).equals("")) {%><span class="blanco" ><%out.print(rs.getString(6));%> <%out.print(rs.getString(3));%><%}%></span></div>
    <input type="text" class="form-control" id="enviado_<%out.print(rs.getString(1));%>" readonly="" value="<%out.print(rs.getString(5));%>"/>
</div>

<%
        }
        rs.close();
        st.close();
    } catch (Exception e) {
        out.print("error PSQL" + e);
    }
} else if (request.getParameter("listar").equals("listarrecibidos")) {
    try {
        String idpedido = request.getParameter("idpedido");
        rs = st.executeQuery("select dp.det_ped_id, ser.ser_descripcion, art.art_nombre, dp.det_ped_precio_unitario, dp.det_ped_cantidad_pedido, ati.articulo_tipo_descripcion, ser.ser_id, art.art_id from detalle_pedido dp, articulos art, servicios ser, articulo_tipo ati where dp.det_ped_art_id_fk = art.art_id and dp.det_ped_ser_id_fk = ser.ser_id and art.articulo_tipo_id = ati.articulo_tipo_id and dp.det_ped_ped_id_fk ='" + idpedido + "' ORDER BY dp.det_ped_id ASC;");
        while (rs.next()) {
%>
<div class="mb-3 control-dark">
    <div class="form-label"><%if (rs.getString(3).equals("")) {%><span class="blanco"><%out.print(rs.getString(2));%><%}%><%if (rs.getString(2).equals("")) {%><span class="blanco" ><%out.print(rs.getString(6));%> <%out.print(rs.getString(3));%><%}%></span></div>
    <input type="text" class="form-control" id="recibido_<%out.print(rs.getString(1));%>" name="<%out.print(rs.getString(1));%>" value="<%out.print(rs.getString(5));%>" oninput="validarSoloNumeros(this)" on/>
</div>
<%
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            out.print("error PSQL" + e);
        }
    } else if (request.getParameter("listar").equals("devolverpedido")) {

        //empieza carga de datos necesarios
        //lo que viene del AJAX
        String datosdevolucion = request.getParameter("datosdevolucion");
        String[] pares = datosdevolucion.split("&");
        for (String par : pares) {
            String[] claveValor = par.split("=");
            if (claveValor.length == 2) {
                String clave = claveValor[0];
                String valor = claveValor[1];
                try {
                    st.executeUpdate("update detalle_pedido set cant_devuelta='" + valor + "' where det_ped_id='" + clave + "'");
                } catch (Exception e) {
                    out.print("error PSQL" + e);
                }
            }
        }
        String aux5 = "";
        Integer art5 = 0;
        String aux6 = "";
        Integer ser5 = 0;
        try {
            String aux4 = request.getParameter("id_pedido");
            id_pedido = Integer.parseInt(aux4);
            rs = st.executeQuery("SELECT det_ped_id, cant_devuelta, det_ped_ser_id_fk, det_ped_art_id_fk FROM detalle_pedido WHERE det_ped_ped_id_fk = '" + id_pedido + "' ORDER BY det_ped_id ASC");
            while (rs.next()) {
                aux5 = rs.getString(4);
                art5 = Integer.parseInt(aux5);
                aux6 = rs.getString(3);
                ser5 = Integer.parseInt(aux6);
                if (art5 != 1) {
                    st.executeUpdate("update articulos set art_existencia= art_existencia + '" + rs.getInt(2) + "' WHERE art_id = '" + rs.getInt(4) + "' ");
                }
                if (ser5 != 1) {
                    st.executeUpdate("update servicios set ser_existencia= ser_existencia + '" + rs.getInt(2) + "' WHERE ser_id = '" + rs.getInt(3) + "'");
                }
            }
            st.executeUpdate("UPDATE pedidos SET entregado = 'DEVUELTO' WHERE ped_id = '" + id_pedido + "'");
            response.setContentType("text/plain");
            out.print("Devuelto satisfactoriamente");

        } catch (Exception e) {
            out.print("error PSQL" + e);
        }
        //iniciar comprobación de faltante de pedidos
        try {
            String aux4 = request.getParameter("id_pedido");
            id_pedido = Integer.parseInt(aux4);
            rs = st.executeQuery("SELECT det_ped_ser_id_fk, det_ped_art_id_fk, det_ped_cantidad_pedido, cant_devuelta, det_ped_precio_unitario FROM detalle_pedido WHERE det_ped_ped_id_fk = '" + id_pedido + "';");
            Integer cantidad = 0;
            while (rs.next()) {
                diferencia_pedido = rs.getInt("det_ped_cantidad_pedido") - rs.getInt("cant_devuelta");
                if (diferencia_pedido != 0) {
                    contador_faltantes++;
                }
            }
        } catch (Exception e) {
            out.print("error PSQL" + e);
        }
        //si hay articulos faltantes
        if (contador_faltantes != 0) {
            //CABECERA 
            String fecha_actual = fechaFormateada;
            String condicion = "CONTADO";
            String empresa = "1";
            try {
                rs = st.executeQuery("SELECT COALESCE(MAX(CAST(nro_factura AS INTEGER)) + 1, 1) AS proximo_nro_factura FROM factura;");
                rs.next();
                nro_factura = rs.getString(1);
            } catch (Exception e) {
                out.println("error PSQL" + e);
            }
            if (nro_factura.length() < 7) {
                int ceros_faltantes = 7 - nro_factura.length();
                for (int i = 0; i < ceros_faltantes; i++) {
                    nro_factura = "0" + nro_factura;
                }
            }
            String idcaja = "";
            try {
                rs = st.executeQuery("SELECT MAX(idcaja) FROM mov_caja");
                if (rs.next()) {
                    idcaja = rs.getString(1);
                }
            } catch (Exception e) {
                out.println("error PSQL" + e);
            }

            //total_factura  ver en if de faltante
            String ruc_cliente = null;
            try {
                rs = st.executeQuery("select p.ped_cli_id_fk, c.cli_ci, c.cli_nombre, c.cli_apellido, c.cli_direccion_maps, c.cli_referencia_direccion from pedidos p INNER JOIN clientes c ON ped_cli_id_fk = cli_id where ped_id = '" + id_pedido + "'");
                rs.next();
            } catch (Exception e) {
                out.println("error PSQL" + e);
            }
            ruc_cliente = rs.getString("cli_ci");
            String razon_social = rs.getString("cli_nombre") + " " + rs.getString("cli_apellido");
            String direccion = rs.getString("cli_direccion_maps") + " " + rs.getString("cli_referencia_direccion");

            //DETALLE 
            /*String cod_art = request.getParameter("codarticulo");
            String cod_ser = request.getParameter("codservicio");
            String precio = request.getParameter("precio");
            String cantidad = request.getParameter("cantidad");
             */
            //INSERTAMOS LA CABECERA
            try {
                ResultSet pk = null;
                //st.executeUpdate("INSERT INTO factura (fecha, condicion, empresa_fk, nro_factura, mov_caja_fk, total_factura, ruc_cliente, razon_social, direccion, estado = 'PENDIENTE')values('" + fecha_actual + "','" + condicion + "','" + empresa + "','" + nro_factura + "','" + idcaja + "','" + total_factura + "','" + ruc_cliente + "', '" + razon_social + "', '" + direccion + "')");
                System.out.println("Datos utilizados en la consulta:");
                System.out.println("fecha_actual: " + fecha_actual);
                System.out.println("condicion: " + condicion);
                System.out.println("empresa: " + empresa);
                System.out.println("nro_factura: " + nro_factura);
                System.out.println("idcaja: " + idcaja);
                System.out.println("ruc_cliente: " + ruc_cliente);
                System.out.println("razon_social: " + razon_social);
                System.out.println("direccion: " + direccion);

                st.executeUpdate("INSERT INTO factura (fecha, condicion, empresa_fk, nro_factura, mov_caja_fk, total_factura, ruc_cliente, razon_social, direccion, estado) VALUES ('" + fecha_actual + "','" + condicion + "','" + empresa + "','" + nro_factura + "','" + idcaja + "','0','" + ruc_cliente + "', '" + razon_social + "', '" + direccion + "', 'PENDIENTE')");
                out.print("Cabecera factura Cargada");
                //se obtiene el ID de la cabecera insertada para poder agregar el detalle.
                pk = st.executeQuery("SELECT idfactura FROM factura where estado='PENDIENTE' ORDER BY idfactura DESC LIMIT 1;");
                pk.next();
                Integer idfactura_pendiente = pk.getInt("idfactura");

                //INSERTAR DETALLE en factura
                System.out.println(id_pedido);
                rs = st.executeQuery("SELECT det_ped_ser_id_fk, det_ped_art_id_fk, det_ped_cantidad_pedido, cant_devuelta, det_ped_precio_unitario FROM detalle_pedido WHERE det_ped_ped_id_fk = '" + id_pedido + "';");
                while (rs.next()) {
                    Integer can_ped = rs.getInt("det_ped_cantidad_pedido");
                    Integer can_dev = rs.getInt("cant_devuelta");
                    if ((can_ped - can_dev) != 0) {
                        Integer diferencia = can_ped - can_dev;
                        System.out.println("idfactura_pendiente: " + idfactura_pendiente);
                        System.out.println("det_ped_ser_id_fk: " + rs.getInt("det_ped_ser_id_fk"));
                        System.out.println("det_ped_art_id_fk: " + rs.getInt("det_ped_art_id_fk"));
                        System.out.println("Precio unitario ajustado: " + (rs.getInt("det_ped_precio_unitario") * 5));
                        System.out.println("Cantidad ajustada: " + (rs.getInt("det_ped_cantidad_pedido") - rs.getInt("cant_devuelta")));
                        st.executeUpdate("INSERT INTO detalle_factura (idfactura, servicio_fk, articulo_fk, precio, cantidad) VALUES('" + idfactura_pendiente + "','" + rs.getInt("det_ped_ser_id_fk") + "','" + rs.getInt("det_ped_art_id_fk") + "','" + ((rs.getInt("det_ped_precio_unitario") * 5) * diferencia) + "','" + (rs.getInt("det_ped_cantidad_pedido") - rs.getInt("cant_devuelta")) + "')");
                    }
                }
                //update de monto total y estado de la factura
                rs = st.executeQuery("SELECT precio,cantidad FROM detalle_factura WHERE idfactura = '" + idfactura_pendiente + "'");
                Integer total_final = 0;
                while (rs.next()) {
                    total_final = total_final + (rs.getInt("precio") * rs.getInt("cantidad"));
                }
                st.executeUpdate("UPDATE factura SET estado = 'EMITIDA', total_factura = '" + total_final + "' WHERE idfactura = '" + idfactura_pendiente + "'");
                out.println("Detalle Cargado");
                out.print("id-" + idfactura_pendiente);

                pk.close();
                st.close();
            } catch (Exception e) {
                out.println("error PSQL1 " + e);
            }
        }
    }
%>