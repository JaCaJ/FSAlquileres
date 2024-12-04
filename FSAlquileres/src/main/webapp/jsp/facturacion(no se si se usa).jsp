<%@include file="conexion.jsp"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%    Date fechaActual = new Date();
    SimpleDateFormat formateadorFecha = new SimpleDateFormat("dd-MM-yyyy");
%>
<%    Statement st = null;
    ResultSet rs = null;
    if (request.getParameter("listar").equals("facturapedido")) {
        //id del pedido del cual se hará la factura
        String idped = request.getParameter("listar");
        Integer idpedido = Integer.parseInt(idped);
        //variables a utilizar
        //factura
        Integer pedido_fk = null;
        String condicion = null;
        String fechaFormateada = formateadorFecha.format(fechaActual);
        Integer empresa_fk = null;
        String nro_factura = null;
        Integer mov_caja_fk = null;
        Integer total_factura = null;
        try {
            st = conn.createStatement();
            rs = st.executeQuery("select * from pedidos ped INNER JOIN usuarios usu ON ped.ped_usu_id_fk = usu.usu_id INNER JOIN clientes cli ON ped.ped_cli_id_fk = cli.cli_id WHERE ped_id = '" + idpedido + "' ;");
            rs.next();

            rs.close();
            st.close();
        } catch (Exception e) {
            out.println("error PSQL" + e);
        }
    }


%>