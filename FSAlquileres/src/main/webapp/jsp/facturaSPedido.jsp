<%@page import="java.text.ParseException"%>
<%@ page import="java.util.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import="java.sql.*" %> 
<%@include file="conexion.jsp"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page import="com.google.gson.Gson"%>
<%//inicio de carga de la factura
    Statement st = null;
    ResultSet rs = null;
    st = conn.createStatement();
    String idPedido = request.getParameter("idpedido");
    String estado = request.getParameter("estado".trim());
    int idpedido = Integer.parseInt(idPedido.trim());
    String total_String = null;
    Integer factura_actual = null;
    String nro_factura = null;
    // Obtener la fecha actual
    Date fechaActual = new Date();
    // Crear un formateador de fecha
    SimpleDateFormat formateadorFecha = new SimpleDateFormat("dd-MM-yyyy");
    // Formatear la fecha
    String fechaFormateada = formateadorFecha.format(fechaActual);

    try {
        rs = st.executeQuery("SELECT * FROM pedidos p inner join clientes c on p.ped_cli_id_fk=c.cli_id where ped_id = '" + idpedido + "' ;");
        rs.next();
        String condicion = "CONTADO";
        Integer empresa_fk = 1;
        Integer total_factura = rs.getInt(8);
        total_String = rs.getString(8);
        rs = st.executeQuery("SELECT COALESCE(MAX(CAST(nro_factura AS INTEGER)) + 1, 1) AS proximo_nro_factura FROM factura;");
        rs.next();
        nro_factura = rs.getString(1);
        // agregar los 0 que faltan al inicio
        if (nro_factura.length() < 7) {
            int ceros_faltantes = 7 - nro_factura.length();
            for (int i = 0; i < ceros_faltantes; i++) {
                nro_factura = "0" + nro_factura;
            }
        }
        if (estado.equals("COBRADO")) {
        System.out.println(estado);
            try {
                st.executeUpdate("insert into factura ( pedido_fk, condicion,  fecha, empresa_fk, nro_factura, mov_caja_fk, total_factura, estado) values ('" + idpedido + "','" + condicion + "' ,'" + fechaFormateada + "','" + empresa_fk + "','" + nro_factura + "',(SELECT MAX(idcaja) FROM mov_caja), '" + total_factura + "', 'COBRADA' )");
            } catch (Exception e) {
                out.println("error PSQL1" + e);
            }
        } else {
            try {
                st.executeUpdate("insert into factura ( pedido_fk, condicion,  fecha, empresa_fk, nro_factura, mov_caja_fk, total_factura) values ('" + idpedido + "','" + condicion + "' ,'" + fechaFormateada + "','" + empresa_fk + "','" + nro_factura + "',(SELECT MAX(idcaja) FROM mov_caja), '" + total_factura + "' )");
            } catch (Exception e) {
                out.println("error PSQL1" + e);
            }
        }
    } catch (Exception e) {
        out.println("error PSQL2" + e);
    }
    //inicio de carga del detalle de la factura
    try {
        rs = st.executeQuery("SELECT MAX(idfactura) FROM factura");
        rs.next();
        factura_actual = rs.getInt(1);
        rs = st.executeQuery("select * from detalle_pedido where det_ped_ped_id_fk ='" + idpedido + "';");
        while (rs.next()) {
            try {
                st.executeUpdate("insert into detalle_factura (idfactura, servicio_fk, articulo_fk, precio, cantidad) values ('" + factura_actual + "','" + rs.getInt(3) + "' ,'" + rs.getInt(4) + "','" + rs.getInt(5) + "','" + rs.getInt(6) + "')");
            } catch (Exception e) {
                out.println("error PSQL3" + e);
            }
        }
    } catch (Exception e) {
        out.println("error PSQL4" + e);
    }

    st.executeUpdate("UPDATE pedidos SET ped_estado = 'FACTURADO' WHERE ped_id = '" + idpedido + "';");

    rs.close();
    st.close();

    total_String = total_String.trim();

    String factura_actual_String = factura_actual.toString();
    factura_actual_String = factura_actual_String.trim();
    //out.print(factura_actual);

    String datos[] = new String[]{};
    datos = new String[]{factura_actual_String, total_String};
    Gson gson = new Gson();
    out.print(gson.toJson(datos));

%>