<%@page import="com.google.gson.Gson"%>
<%@include file="conexion.jsp"%>
<%    Statement st = null;
    ResultSet rs = null;
    st = conn.createStatement();
    if (request.getParameter("listar").equals("cargar")) {
        /* CABECERA */
        String ped_fecha_pedido = request.getParameter("ped_fecha_pedido");
        String ped_fecha_entrega = request.getParameter("ped_fecha_entrega");
        String ped_fecha_retiro = request.getParameter("ped_fecha_retiro");
        //lo de abajo se comenta porque se lleva a utilizar otro lado y se deja para saber que existe
        String ped_observacion = request.getParameter("ped_observacion");
        String ped_usu_id_fk = request.getParameter("ped_usu_id_fk");
        String ped_cli_id_fk = request.getParameter("ped_cli_id_fk");
        /*String aux = request.getParameter("ped_costo_total");
        int ped_costo_total = Integer.parseInt(aux);*/
        String ped_costo_total = request.getParameter("ped_costo_total");
        String ped_direccion = request.getParameter("ped_direccion");
        String cel_cliente = request.getParameter("cel_cliente");

        /* DETALLE */
        String det_ped_ped_id_fk = request.getParameter("det_ped_ped_id_fk");
        String cod_art = request.getParameter("codproducto");
        String cod_ser = request.getParameter("codservicio");
        String precio = request.getParameter("det_ped_precio_unitario");
        String cantidad = request.getParameter("det_ped_cantidad_pedido");

        System.out.println(
                "Fecha Pedido: " + ped_fecha_pedido + ", "
                + "Fecha Entrega: " + ped_fecha_entrega + ", "
                + "Fecha Retiro: " + ped_fecha_retiro + ", "
                + "Observación: " + ped_observacion + ", "
                + "Usuario ID: " + ped_usu_id_fk + ", "
                + "Cliente ID: " + ped_cli_id_fk + ", "
                + "Costo Total: " + ped_costo_total + ", "
                + "Código Artículo: " + cod_art + ", "
                + "Precio: " + precio + ", "
                + "Cantidad: " + cantidad
        );
        rs = st.executeQuery("SELECT ped_id FROM pedidos where ped_estado='PENDIENTE'");
        //si hay pedido pendiente insertar solo detalle
        if (rs.next()) {
            try {
                // Consulta para verificar si el artículo o servicio ya está en el pedido
                ResultSet rp = null;
                rp = st.executeQuery("SELECT COUNT(*) FROM detalle_pedido WHERE det_ped_ped_id_fk = '" + rs.getString(1) + "' AND (det_ped_art_id_fk = '" + cod_art + "' AND det_ped_ser_id_fk = '" + cod_ser + "')");
                rp.next();
// Si ya existe, mostrar la alerta en el frontend
                Integer aux = rp.getInt(1);
                if (aux > 0) {
                    // Alert en JavaScript desde Java usando response
                    out.print("Ya existe el artículo/servicio en el pedido. Para modificar la cantidad, elimínelo e ingréselo de nuevo.");
                } else {
                    // Si no existe, se comprueba que el pedido no supere la existencia para luego proceder con la inserción
                    if (!cod_art.equals("1")) {
                        ResultSet ca = null;
                        ca = st.executeQuery("SELECT art_existencia FROM articulos WHERE art_id = '" + cod_art + "';");
                        ca.next();
                        int aux1 = ca.getInt(1);
                        ca.close();
                        if (Integer.parseInt(cantidad) > aux1) {
                            out.print("Error: Artículo insuficiente.");
                        } else {
                            st.executeUpdate("insert into detalle_pedido(det_ped_ped_id_fk,det_ped_cantidad_pedido,det_ped_precio_unitario,det_ped_art_id_fk,det_ped_ser_id_fk)values('" + rs.getString(1) + "','" + cantidad + "','" + precio + "','" + cod_art + "','" + cod_ser + "')");
                            st.executeUpdate("update articulos set art_existencia = ( art_existencia - '" + cantidad + "') WHERE art_id = '" + cod_art + "';");
                            out.print("detalle insertado");
                        }
                    }
                    if (!cod_ser.equals("1")) {
                        ResultSet ca = null;
                        ca = st.executeQuery("SELECT ser_existencia FROM servicios WHERE ser_id = '" + cod_ser + "';");
                        ca.next();
                        //Se comprueba que el pedido no supere a la existencia.
                        int aux2 = ca.getInt(1);
                        ca.close();
                        if (Integer.parseInt(cantidad) > aux2) {
                            out.print("Error: Cantidad de servicio insuficiente.");
                        } else {
                            st.executeUpdate("insert into detalle_pedido(det_ped_ped_id_fk,det_ped_cantidad_pedido,det_ped_precio_unitario,det_ped_art_id_fk,det_ped_ser_id_fk)values('" + rs.getString(1) + "','" + cantidad + "','" + precio + "','" + cod_art + "','" + cod_ser + "')");
                            st.executeUpdate("update servicios set ser_existencia = ( ser_existencia - '" + cantidad + "') WHERE ser_id = '" + cod_ser + "';");
                            out.print("detalle insertado");
                        }
                    }
                }
                /*
                System.out.println(
                        "Fecha Pedido: " + ped_fecha_pedido + ", "
                        + "Fecha Entrega: " + ped_fecha_entrega + ", "
                        + "Fecha Retiro: " + ped_fecha_retiro + ", "
                        + "Observación: " + ped_observacion + ", "
                        + "Usuario ID: " + ped_usu_id_fk + ", "
                        + "Cliente ID: " + ped_cli_id_fk + ", "
                        + "Costo Total: " + ped_costo_total + ", "
                        + "Código Artículo: " + cod_art + ", "
                        + "Precio: " + precio + ", "
                        + "Cantidad: " + cantidad
                );
                 */
                rp.close();
            } catch (Exception e) {
                out.println("error PSQL" + e);
            }
            rs.close();
            st.close();
        } else {
            /*INSERTAMOS LA CABECERA*/
            try {
                ResultSet pk = null;
                st.executeUpdate("insert into pedidos(ped_fecha_pedido,ped_fecha_entrega,ped_fecha_retiro,ped_observacion,ped_usu_id_fk,ped_cli_id_fk,ped_costo_total, ped_direccion, ped_cli_cel)values('" + ped_fecha_pedido + "','" + ped_fecha_entrega + "','" + ped_fecha_retiro + "','" + ped_observacion + "','" + ped_usu_id_fk + "','" + ped_cli_id_fk + "','" + ped_costo_total + "', '" + ped_direccion + "', '" + cel_cliente + "')");
                out.print("Cabecera Cargada");
                //se obtiene el ID de la cabecera insertada para poder agregar el detalle.
                pk = st.executeQuery("SELECT ped_id FROM pedidos where ped_estado='PENDIENTE'");
                pk.next();
                //si se quiere insertar un artículo.
                if (!cod_art.equals("1")) {
                    ResultSet ca = null;
                    ca = st.executeQuery("SELECT art_existencia FROM articulos WHERE art_id = '" + cod_art + "';");
                    ca.next();
                    //Se comprueba que el pedido no supere a la existencia.
                    int aux3 = ca.getInt(1);
                    ca.close();
                    if (Integer.parseInt(cantidad) > aux3) {
                        out.print("Error: Artículo insuficiente.");
                    } else {
                        st.executeUpdate("insert into detalle_pedido(det_ped_ped_id_fk,det_ped_cantidad_pedido,det_ped_precio_unitario,det_ped_art_id_fk,det_ped_ser_id_fk)values('" + pk.getString(1) + "','" + cantidad + "','" + precio + "','" + cod_art + "','" + cod_ser + "')");
                        st.executeUpdate("update articulos set art_existencia = ( art_existencia - '" + cantidad + "') WHERE art_id = '" + cod_art + "';");
                        out.print("Detalle Cargado");
                    }
                }
                if (!cod_ser.equals("1")) {
                    ResultSet ca = null;
                    ca = st.executeQuery("SELECT ser_existencia FROM servicios WHERE ser_id = '" + cod_ser + "';");
                    ca.next();
                    //Se comprueba que el pedido no supere a la existencia.
                    int aux4 = ca.getInt(1);
                    ca.close();
                    if (Integer.parseInt(cantidad) > aux4) {
                        out.print("Error: Cantidad de servicio insuficiente.");
                    } else {
                        st.executeUpdate("insert into detalle_pedido(det_ped_ped_id_fk,det_ped_cantidad_pedido,det_ped_precio_unitario,det_ped_art_id_fk,det_ped_ser_id_fk)values('" + pk.getString(1) + "','" + cantidad + "','" + precio + "','" + cod_art + "','" + cod_ser + "')");
                        st.executeUpdate("update servicios set ser_existencia = ( ser_existencia - '" + cantidad + "') WHERE ser_id = '" + cod_ser + "';");
                        out.print("Detalle Cargado");
                    }
                }
                /*
                        System.out.println(
                        "Fecha Pedido: " + ped_fecha_pedido + ", "
                        + "Fecha Entrega: " + ped_fecha_entrega + ", "
                        + "Fecha Retiro: " + ped_fecha_retiro + ", "
                        + "Observación: " + ped_observacion + ", "
                        + "Usuario ID: " + ped_usu_id_fk + ", "
                        + "Cliente ID: " + ped_cli_id_fk + ", "
                        + "Costo Total: " + ped_costo_total + ", "
                        + "Código Artículo: " + cod_art + ", "
                        + "Precio: " + precio + ", "
                        + "Cantidad: " + cantidad
                );
                 */

                pk.close();
                st.close();
            } catch (Exception e) {
                out.println("error PSQL" + e);
            }
        }
    } else if (request.getParameter("listar").equals("buscararticulo")) {
        try {
            rs = st.executeQuery("SELECT * FROM articulos art INNER JOIN articulo_tipo ati ON art.articulo_tipo_id = ati.articulo_tipo_id WHERE NOT art_id='1' AND art_estado = 'ACTIVO' ORDER BY art_id ASC;");
%>
<option value="">Seleccionar</option>

<%
    while (rs.next()) {
%>
<option value="<% out.print(rs.getString(1)); %>,<% out.print(rs.getString(3)); %>"> 
    <%out.print(rs.getString(8));%> <%out.print(rs.getString(2));%>|
    <% out.print(rs.getString(5)); %>
</option>    
<%
        }
        rs.close();
        st.close();
    } catch (Exception e) {
        out.print("error PSQL" + e);
    }
} else if (request.getParameter("listar").equals("buscarservicio")) {
    try {
        ResultSet ss = null;
        ss = st.executeQuery("select * from servicios WHERE NOT ser_id='1' order by ser_id ASC;");
%>
<option value="">Seleccionar</option>

<%
    while (ss.next()) {
%>
<option value="<% out.print(ss.getString(1)); %>,<% out.print(ss.getString(3)); %>"> 
    <% out.print(ss.getString(2)); %>|
    <% out.print(ss.getString(4)); %>
</option>    
<%
        }
        ss.close();
        st.close();
    } catch (Exception e) {
        out.print("error PSQL" + e);
    }
} else if (request.getParameter("listar").equals("buscarcliente")) {
    try {
        ResultSet cs = null;
        cs = st.executeQuery("select * from clientes order by cli_id ASC;");
%>
<option value="">Seleccionar</option>

<%
    while (cs.next()) {
%>
<option value="<% out.print(cs.getString(1)); %>,<% out.print(cs.getString(4)); %>,<% out.print(cs.getString(5)); %>,<% out.print(cs.getString(6)); %>,<% out.print(cs.getString(7)); %>"> 
    <% out.print(cs.getString(4)); %>|
    <% out.print(cs.getString(2)); %>|
    <% out.print(cs.getString(3)); %>
</option>    
<%
        }
        cs.close();
        st.close();
    } catch (Exception e) {
        out.print("error PSQL" + e);
    }
} else if (request.getParameter("listar").equals("listarcabecera")) {
    try {

        ResultSet pk = null;
        ResultSet detCab = null;
        st = conn.createStatement();
        String cab[] = new String[]{};
        pk = st.executeQuery("SELECT ped_id FROM pedidos where ped_estado='PENDIENTE'");
        detCab = st.executeQuery("SELECT ped.*, cli.* FROM pedidos ped inner join clientes cli on ped_cli_id_fk=cli_id where ped_estado='PENDIENTE'");
        if (pk.next()) {
            detCab.next();
            cab = new String[]{detCab.getString(1), detCab.getString(2), detCab.getString(3), detCab.getString(4), detCab.getString(5), detCab.getString(6), detCab.getString(7), detCab.getString(8), detCab.getString(9), detCab.getString(10), detCab.getString(11), detCab.getString(12), detCab.getString(13), detCab.getString(14), detCab.getString(15), detCab.getString(16), detCab.getString(17), detCab.getString(18)};
            Gson gson = new Gson();
            out.print(gson.toJson(cab));
        }
        pk.close();
        detCab.close();
        st.close();
    } catch (Exception e) {
        out.print("error PSQL" + e);
    }
} else if (request.getParameter("listar").equals("listar")) {
    try {
        ResultSet pk = null;
        pk = st.executeQuery("SELECT ped_id FROM pedidos where ped_estado='PENDIENTE'");
        if (pk.next()) {
            rs = st.executeQuery("select dp.det_ped_id, ser.ser_descripcion, art.art_nombre, dp.det_ped_precio_unitario, dp.det_ped_cantidad_pedido, ati.articulo_tipo_descripcion, ser.ser_id, art.art_id from detalle_pedido dp, articulos art, servicios ser, articulo_tipo ati where dp.det_ped_art_id_fk = art.art_id and dp.det_ped_ser_id_fk = ser.ser_id and art.articulo_tipo_id = ati.articulo_tipo_id and dp.det_ped_ped_id_fk ='" + pk.getString(1) + "';");
            while (rs.next()) {
                String precio = rs.getString(4);
                String cantidad = rs.getString(5);
                Integer precioI = Integer.parseInt(precio);
                Integer cantidadI = Integer.parseInt(cantidad);
                int calculo = precioI * cantidadI;
%>
<tr>
    <td>
        <div class="actions"><a class="deleteRow"><i class="icon-delete_outline text-red iHover" data-bs-toggle="modal" data-bs-target="#modalDark" title="Eliminar registro." onclick="$('#idpk').val(<% out.print(rs.getString(1));%>);$('#cantPed').val(<%out.print(rs.getString(5));%>);$('#idser').val(<%out.print(rs.getString(7));%>);$('#idart').val(<%out.print(rs.getString(8));%>);"></i></a></div>
    </td>
    <td><% out.print(rs.getString(1));%></td>

    <%if (rs.getString(3).equals("")) {%>
    <td><%out.print(rs.getString(2));%></td>
    <%}%>
    <%if (rs.getString(2).equals("")) {%>
    <td><%out.print(rs.getString(6));%> <%out.print(rs.getString(3));%></td>
    <%}%>
    <td><% out.print(rs.getString(4));%></td>    
    <td><% out.print(rs.getString(5));%></td>    
    <td><% out.print(calculo);%></td>
</tr>
<%
            }
            rs.close();
        }
        pk.close();
        st.close();
    } catch (Exception e) {
        out.print("error PSQL" + e);
    }
} else if (request.getParameter("listar").equals("mostrartotales")) {
    try {
        ResultSet pk = null;
        int sumador = 0;
        pk = st.executeQuery("SELECT ped_id FROM pedidos where ped_estado='PENDIENTE'");
        if (pk.next()) {
            rs = st.executeQuery("select dp.det_ped_id, a.art_nombre, dp.det_ped_precio_unitario, dp.det_ped_cantidad_pedido from detalle_pedido dp, articulos a where dp.det_ped_art_id_fk = a.art_id and dp.det_ped_ped_id_fk = '" + pk.getString(1) + "';");
            while (rs.next()) {
                String precio = rs.getString(3);
                String cantidad = rs.getString(4);
                Integer precioI = Integer.parseInt(precio);
                Integer cantidadI = Integer.parseInt(cantidad);
                int calculo = precioI * cantidadI;
                sumador += calculo;
            }
            out.println(sumador);
            rs.close();
        } else {
            sumador = 0;
            out.println(sumador);
        }
        pk.close();
        st.close();
    } catch (Exception e) {
        out.println("error PSQL" + e);
    }

} else if (request.getParameter("listar").equals("eliminardetalle")) {
    String pk = request.getParameter("pk");
    String cantPed = request.getParameter("cantPed");
    String idart = request.getParameter("idart");
    String idser = request.getParameter("idser");
    try {
        if (!idart.equals("1")) {
            st.executeUpdate("UPDATE articulos SET art_existencia = ( art_existencia + '" + cantPed + "') WHERE art_id ='" + idart + "'");
        }
        if (!idser.equals("1")) {
            st.executeUpdate("UPDATE servicios SET ser_existencia = ( ser_existencia + '" + cantPed + "') WHERE ser_id ='" + idser + "'");
        }
        st.executeUpdate("delete from detalle_pedido where det_ped_id='" + pk + "'");
        st.close();
    } catch (Exception e) {
        out.print("error PSQL" + e);
    }
} else if (request.getParameter("listar").equals("cancelarpedido")) {
    try {
        ResultSet pk = null;
        pk = st.executeQuery("SELECT ped_id FROM pedidos where ped_estado='PENDIENTE'");
        if (pk.next()) {
            rs = st.executeQuery("select dp.det_ped_id, ser.ser_descripcion, art.art_nombre, dp.det_ped_precio_unitario, dp.det_ped_cantidad_pedido, ati.articulo_tipo_descripcion, ser.ser_id, art.art_id from detalle_pedido dp, articulos art, servicios ser, articulo_tipo ati where dp.det_ped_art_id_fk = art.art_id and dp.det_ped_ser_id_fk = ser.ser_id and art.articulo_tipo_id = ati.articulo_tipo_id and dp.det_ped_ped_id_fk ='" + pk.getString(1) + "';");
            while (rs.next()) {
                int idarti = rs.getInt(8);
                int idserv = rs.getInt(7);
                int cantPedi = rs.getInt(5);
                if (idarti != 1) {
                    st.executeUpdate("UPDATE articulos SET art_existencia = ( art_existencia + '" + cantPedi + "') WHERE art_id ='" + idarti + "'");
                }
                if (idserv != 1) {
                    st.executeUpdate("UPDATE servicios SET ser_existencia = ( ser_existencia + '" + cantPedi + "') WHERE ser_id ='" + idserv + "'");
                }
            }
            st.executeUpdate("update pedidos set ped_estado='CANCELADO' where ped_id='" + pk.getString(1) + "'");
            rs.close();
        }
        pk.close();
        st.close();
    } catch (Exception e) {
        out.print("error PSQL" + e);
    }
} else if (request.getParameter("listar").equals("finalizarventa")) {
    try {
        ResultSet pk = null;
        pk = st.executeQuery("SELECT ped_id FROM pedidos where ped_estado='PENDIENTE'");
        if (pk.next()) {
            st.executeUpdate("update pedidos set ped_estado='FINALIZADO', ped_costo_total='" + request.getParameter("total") + "', ped_observacion='" + request.getParameter("observacion") + "' where ped_id='" + pk.getString(1) + "'");
        }
        pk.close();
        st.close();
    } catch (Exception e) {
        out.println("error PSQL" + e);
    }
} else if (request.getParameter("listar").equals("listarpedidos")) {
    try {
        rs = st.executeQuery("select to_char(p.ped_fecha_pedido,'dd-mm-YYYY'),c.cli_nombre, c.cli_apellido. p.costo_total, p.pedido_id from pedidos p, clientes c where p.ped_cli_id_fk = c.cli_id and p.ped_estado='FINALIZADO';");
        while (rs.next()) {
%>
<tr>
    <td><% out.print(rs.getString(5)); %></td>
    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(2) + ' ' + rs.getString(3)); %></td>
    <td><% out.print(rs.getString(4)); %></td>
    <td>
        <i class ="fa fa-trash" style="color:red" data-toggle="modal" data-target="#exampleModal" onclick="$('#idpk').val(<% out.print(rs.getString(5)); %>)"></i>
    </td>
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
            out.println("error PSQL" + e);
        }
    }
%>