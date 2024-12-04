<%@include file="conexion.jsp"%>
<% /*if (request.getParameter("listar").equals("listar")) {
        try {
            Statement st = null;
            ResultSet rs = null;
            st = conn.createStatement();
            rs = st.executeQuery("SELECT * FROM pedidos p inner join clientes c on p.ped_cli_id_fk=c.cli_id where ped_estado='FINALIZADO';");
            while (rs.next()) {
     */
%>
<!-- 
<tr>
    <td> 
        <i class="icon-delete_outline text-red iHover" title="Anular registro" data-bs-toggle="modal" data-bs-target="#modalDark" onclick="$('#idpk').val(<%// out.print(rs.getString(1)); %>)">
        </i>
        <i class="icon-add_business text-white iHover" title="Generar comprobante" onclick="abrirReporte('<%// out.print(rs.getString(1)); %>');">
        </i>
        <i class="icon-library_add_check text-green iHover" title="Devolver artículos" onclick="abrirReporte('<%// out.print(rs.getString(1)); %>');">
        </i>

    </td>
    <td><%// out.print(rs.getString(2)); %></td>
    <td><%// out.print(rs.getString(13)); %> <%// out.print(rs.getString(14)); %> <%// out.print(rs.getString(15)); %></td>
    <td><%// out.print(rs.getString(8)); %></td>
</tr>
-->
<%
    /*
        }
        rs.close();
        st.close();
    } catch (Exception e) {
        out.println("error PSQL" + e);
    }
} */
    if (request.getParameter("listar").equals("listarfacturas")) {
        try {
            Statement st = null;
            ResultSet rs = null;
            st = conn.createStatement();
            //rs = st.executeQuery("SELECT * FROM factura INNER JOIN empresa ON empresa_fk = idempresa INNER JOIN pedidos ON pedido_fk = pedidos.ped_id INNER JOIN clientes ON pedidos.ped_cli_id_fk = clientes.cli_id ORDER BY idfactura DESC;");
            rs = st.executeQuery("SELECT * FROM factura INNER JOIN empresa ON empresa_fk = idempresa INNER JOIN mov_caja ON mov_caja_fk = idcaja INNER JOIN usuarios ON usuario = usuarios.usu_id LEFT JOIN pedidos ON pedido_fk = ped_id LEFT JOIN clientes ON ped_cli_id_fk = cli_id ORDER BY idfactura DESC;");
            while (rs.next()) {
%>
<tr>
    <td> 
        <%if (!rs.getString(9).equals("ANULADA")) {%>
        <i class="icon-delete_outline text-red iHover" title="Anular factura" data-bs-toggle="modal" data-bs-target="#modalDark3" onclick="$('#idfactura').val(<% out.print(rs.getString(1)); %>)">
        </i>
        <%}%>
        <i class="icon-picture_as_pdf text-white iHover" title="Reimprimir factura" onclick="reimprimirFactura('<% out.print(rs.getString(1)); %>');">
        </i>
        <%if (rs.getString(9).equals("EMITIDA")) {%>
        <i class="icon-attach_money text-green iHover" title="Cobrar" onclick="cobrarfactura('<% out.print(rs.getString(1)); %>');">
        </i>
        <%}%>
    </td>
    <td><% out.print(rs.getString(6)); %></td>
    <%if (rs.getString("pedido_fk") == null) {%>
        <td><% out.print(rs.getString(10)); %> <% out.print(rs.getString(11)); %></td>
    <%} else {%>
        <td><% out.print(rs.getString("cli_ci")); %> <% out.print(rs.getString("cli_nombre")); %> <% out.print(rs.getString("cli_apellido")); %></td>
    <%}%>
    <td><% out.print(rs.getString(8)); %></td>
    <td><% out.print(rs.getString(9)); %></td>
</tr>
<%
        }
        rs.close();
        st.close();
    } catch (Exception e) {
        out.println("error PSQL" + e);
    }
} else if (request.getParameter("listar").equals("listarpedidos")) {
    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("SELECT * FROM pedidos p inner join clientes c on p.ped_cli_id_fk=c.cli_id where ped_estado='FINALIZADO' OR ped_estado='COBRADO' ORDER BY ped_id DESC;");
        while (rs.next()) {
%>
<tr>
    <td>
        <%if (rs.getString(9).equals("FINALIZADO")) {%>
        <i class="icon-attach_money text-white iHover" title="Cobrar" onclick="cobrarpedido('<% out.print(rs.getString(1)); %>');">
        </i>
        <%}%>
        <i class="icon-picture_as_pdf text-white iHover" title="Generar factura" onclick="generarFactura('<% out.print(rs.getString(1)); %>', '<% out.print(rs.getString(9)); %>');" data-bs-dismiss="modal">
        </i>
    </td>
    <td><% out.print(rs.getString(2)); %></td>
    <td><% out.print(rs.getString(13)); %> <% out.print(rs.getString(14)); %> <% out.print(rs.getString(15)); %></td>
    <td><% out.print(rs.getString(9)); %></td>
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
            Statement st = null;
            st = conn.createStatement();
            st.executeUpdate("update pedidos set ped_estado='ANULADO' where ped_id='" + request.getParameter("pkd") + "'");
            st.close();
        } catch (Exception e) {
            out.println("error PSQL" + e);
        }
    } else if (request.getParameter("listar").equals("anularfactura")) {
        String idfactura = request.getParameter("idfactura");
        try {
            Statement st = null;
            st = conn.createStatement();
            ResultSet rs = null;
            rs = st.executeQuery("SELECT pedido_fk from factura where idfactura ='" + idfactura + "'");
            rs.next();
            st.executeUpdate("update pedidos set ped_estado = 'COBRADO' where ped_id ='" + rs.getInt(1) + "'");
            st.executeUpdate("update factura set estado='ANULADA' where idfactura='" + idfactura + "'");
            st.close();
            rs.close();
            out.print("Factura anulada.");

        } catch (Exception e) {
            out.println("error PSQL" + e);
        }
    } else if (request.getParameter("listar").equals("cobrarpedido")) {
        String idpedido = request.getParameter("idpedido");
        Statement st = null;
        st = conn.createStatement();
        ResultSet rs = null;
        rs = st.executeQuery("SELECT ped_costo_total FROM pedidos WHERE ped_id = '" + idpedido + "'");
        rs.next();
        Integer montoAcobrar = rs.getInt(1);
        try {
            st.executeUpdate("update mov_caja set monto_total= (monto_total + '" + montoAcobrar + "')  where idcaja= (SELECT MAX(idcaja) FROM mov_caja)");
            st.executeUpdate("update pedidos set ped_estado='COBRADO' where ped_id='" + idpedido + "'");
            out.print("cobrado");
            st.close();
        } catch (Exception e) {
            out.println("error PSQL" + e);
        }
    } else if (request.getParameter("listar").equals("cobrarfactura")) {
        String idfactura = request.getParameter("idfactura");
        Statement st = null;
        st = conn.createStatement();
        ResultSet rs = null;
        rs = st.executeQuery("SELECT total_factura FROM factura WHERE idfactura = '" + idfactura + "'");
        rs.next();
        Integer montoAcobrar = rs.getInt(1);
        try {
            st.executeUpdate("update mov_caja set monto_total= (monto_total + '" + montoAcobrar + "')  where idcaja= (SELECT MAX(idcaja) FROM mov_caja)");
            st.executeUpdate("update factura set estado='COBRADA' where idfactura='" + idfactura + "'");
            out.print("COBRADA");
            st.close();
        } catch (Exception e) {
            out.println("error PSQL" + e);
        }
    }
%>