<%@page import="com.google.gson.Gson"%>
<%@include file="conexion.jsp"%>
<%    //declaracion de elementos a utilizar
    Statement st = null;
    ResultSet rs = null;
    st = conn.createStatement();
    String nrofactura = null;
    Integer total_factura = 0;
    String nro_factu = "";

    if (request.getParameter("listar").equals("cargar")) {
        /* CABECERA */
        String fecha_actual = request.getParameter("fecha_actual");
        String condicion = request.getParameter("condicion");
        String empresa = "1";
        nro_factu = request.getParameter("nro_factura");
        String idcaja = request.getParameter("idcaja");
        String total_fac = request.getParameter("total_factura");
        if (total_fac.equals("")) {
            total_fac = "0";
        }
        total_factura = Integer.parseInt(total_fac.trim());
        String ruc_cliente = request.getParameter("ruc_cliente");
        String razon_social = request.getParameter("razon_social");
        String direccion = request.getParameter("direccion");

        /* DETALLE */
        String cod_art = request.getParameter("codarticulo");
        String cod_ser = request.getParameter("codservicio");
        String precio = request.getParameter("precio");
        String cantidad = request.getParameter("cantidad");

        rs = st.executeQuery("SELECT idfactura FROM factura WHERE estado='PENDIENTE'");
        //si hay pedido pendiente insertar solo detalle
        if (rs.next()) {
            try {
                st.executeUpdate("insert into detalle_factura (idfactura, servicio_fk, articulo_fk, precio, cantidad) values('" + rs.getString(1) + "','" + cod_ser + "','" + cod_art + "','" + precio + "','" + cantidad + "')");
            } catch (Exception e) {
                out.println("error PSQL" + e);
            }
            rs.close();
            st.close();
        } else {
            /*INSERTAMOS LA CABECERA*/
            try {
                ResultSet pk = null;
                st.executeUpdate("INSERT INTO factura (fecha, condicion, empresa_fk, nro_factura, mov_caja_fk, total_factura, ruc_cliente, razon_social, direccion, estado)values('" + fecha_actual + "','" + condicion + "','" + empresa + "','" + nro_factu + "','" + idcaja + "','" + total_factura + "','" + ruc_cliente + "', '" + razon_social + "', '" + direccion + "', 'PENDIENTE')");
                out.print("Cabecera Cargada");
                //se obtiene el ID de la cabecera insertada para poder agregar el detalle.
                pk = st.executeQuery("SELECT idfactura FROM factura where estado='PENDIENTE'");
                pk.next();
                st.executeUpdate("insert into detalle_factura (idfactura, servicio_fk, articulo_fk, precio, cantidad) values('" + pk.getString(1) + "','" + cod_ser + "','" + cod_art + "','" + precio + "','" + cantidad + "')");
                out.print("Detalle Cargado");
                pk.close();
                st.close();
            } catch (Exception e) {
                out.println("error PSQL1" + e);
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
} else if (request.getParameter("listar").equals("listarcabecera")) {
    try {
        ResultSet pk = null;
        ResultSet detCab = null;
        st = conn.createStatement();
        String cab[] = new String[]{};
        pk = st.executeQuery("SELECT * FROM factura where estado='PENDIENTE'");
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
        pk = st.executeQuery("SELECT idfactura FROM factura WHERE estado='PENDIENTE'");
        if (pk.next()) {
            rs = st.executeQuery("SELECT df.iddetallefactura, ser.ser_descripcion, art.art_nombre, df.precio, df.cantidad, ati.articulo_tipo_descripcion, ser.ser_id, art.art_id FROM detalle_factura df, articulos art, servicios ser, articulo_tipo ati WHERE df.articulo_fk = art.art_id AND df.servicio_fk = ser.ser_id AND art.articulo_tipo_id = ati.articulo_tipo_id AND idfactura = '" + pk.getString(1) + "' ORDER BY df.iddetallefactura DESC;");
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
        pk = st.executeQuery("SELECT idfactura FROM factura where estado='PENDIENTE'");
        if (pk.next()) {
            rs = st.executeQuery("SELECT df.idfactura, df.precio, df.cantidad FROM detalle_factura df WHERE idfactura = '" + pk.getString(1) + "';");
            while (rs.next()) {
                String precio = rs.getString(2);
                String cantidad = rs.getString(3);
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
} else if (request.getParameter("listar").equals("cancelarfactura")) {
    try {
        ResultSet pk = null;
        pk = st.executeQuery("SELECT idfactura FROM factura WHERE estado='PENDIENTE'");
        if (pk.next()) {
            st.executeUpdate("UPDATE factura SET estado='CANCELADO' WHERE idfactura ='" + pk.getString(1) + "'");
        }
        pk.close();
        st.close();
    } catch (Exception e) {
        out.print("error PSQL" + e);
    }
} else if (request.getParameter("listar").equals("finalizarfacturacion")) {
    try {
        ResultSet pk = null;
        pk = st.executeQuery("SELECT idfactura FROM factura WHERE estado='PENDIENTE'");
        if (pk.next()) {
            st.executeUpdate("UPDATE factura SET estado='EMITIDA', total_factura='" + request.getParameter("total") + "'  WHERE idfactura='" + pk.getString(1) + "'");
            out.println("emitida-" + pk.getString("idfactura"));
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
    } else if (request.getParameter("listar").equals("rellenarcampos")) {
        try {
            ResultSet camp = null;
            st = conn.createStatement();
            String cam[] = new String[]{};
            camp = st.executeQuery("SELECT * FROM empresa INNER JOIN mov_caja ON empresa.idempresa = 1 INNER JOIN usuarios ON mov_caja.usuario = usuarios.usu_id ORDER BY mov_caja.idcaja DESC LIMIT 1;");
            camp.next();
            cam = new String[]{camp.getString(2), camp.getString(3), camp.getString(4), camp.getString(5), camp.getString(14), camp.getString(6)};

            rs = st.executeQuery("SELECT nro_factura FROM factura WHERE estado = 'PENDIENTE'");
            if (rs.next()) {
                nrofactura = rs.getString(1);
            } else {
                rs = st.executeQuery("SELECT COALESCE(MAX(CAST(nro_factura AS INTEGER)) + 1, 1) AS proximo_nro_factura FROM factura;");
                rs.next();
                nrofactura = rs.getString(1);
                // agregar los 0 que faltan al inicio de nro_factura
                if (nrofactura.length() < 7) {
                    int ceros_faltantes = 7 - nrofactura.length();
                    for (int i = 0; i < ceros_faltantes; i++) {
                        nrofactura = "0" + nrofactura;
                    }
                }
            }

            // Inicializar variables para los campos adicionales
            String rucCliente = "", razonSocial = "", direccion = "";

            try {
                ResultSet pk = null;
                st = conn.createStatement();
                pk = st.executeQuery("SELECT ruc_cliente, razon_social, direccion FROM factura WHERE estado='PENDIENTE'");
                if (pk.next()) {
                    // Obtener valores de ruc_cliente, razon_social, y direccion
                    rucCliente = pk.getString("ruc_cliente");
                    razonSocial = pk.getString("razon_social");
                    direccion = pk.getString("direccion");
                }
                pk.close();
            } catch (Exception e) {
                out.print("Error al obtener información de cliente: " + e);
            }

            // agregar el nro_factura y campos adicionales manipulando el array
            int nuevosCampos = rucCliente.isEmpty() ? 4 : 4; // 1 si no hay campos adicionales, 4 si sí hay
            String[] nuevoCam = new String[cam.length + nuevosCampos];
            System.arraycopy(cam, 0, nuevoCam, 0, cam.length);
            nuevoCam[cam.length] = nrofactura;

            // Agregar campos adicionales si existen
            if (!rucCliente.isEmpty()) {
                nuevoCam[cam.length + 1] = rucCliente;
                nuevoCam[cam.length + 2] = razonSocial;
                nuevoCam[cam.length + 3] = direccion;
            } else {
                nuevoCam[cam.length + 1] = "";
                nuevoCam[cam.length + 2] = "";
                nuevoCam[cam.length + 3] = "";
            }

            cam = nuevoCam;

            Gson gson = new Gson();
            out.print(gson.toJson(cam));

            camp.close();
            st.close();
        } catch (Exception e) {
            out.print("error PSQL" + e);
        }
    }
%>