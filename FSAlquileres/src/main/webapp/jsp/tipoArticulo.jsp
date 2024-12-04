
<%@include file="conexion.jsp"%>
<% if (request.getParameter("listar").equals("listar")) {
        try {
            Statement st = null;
            ResultSet rs = null;
            st = conn.createStatement();
            rs = st.executeQuery("select * from articulo_tipo WHERE articulo_tipo_estado = 'ACTIVO' AND NOT articulo_tipo_id = 1;");
            while (rs.next()) {
%>
<tr>
    <td>
        <!-- Icono EDITAR -->
        <i class="icon-create text-green iHover" 
           title="Editar" 
           onclick="rellenar('<% out.print(rs.getString(1)); %>', '<% out.print(rs.getString(2)); %>')">
        </i>
        <!-- Icono ELIMINAR -->
        <i class="icon-delete_outline text-red iHover" 
           title="Eliminar" 
           data-bs-toggle="modal" 
           data-bs-target="#modalDark" 
           onclick="$('#pkdel').val('<% out.print(rs.getString(1)); %>')">
        </i>
        <!-- Icono REPORTE -->
        <i class="icon-picture_as_pdf text-white iHover" 
           title="Reporte" 
           onclick="abrirReporte('<% out.print(rs.getString(1)); %>');">
        </i>
    </td>
    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(2)); %></td>
</tr>
<%
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            out.print("error PSQL" + e);
        }
    } else if (request.getParameter("listar").equals("cargar")) {
        String tipoArt = request.getParameter("tipoArt");
        tipoArt = tipoArt.toUpperCase();
        String valor = null;
        try {
            Statement st = null;
            ResultSet rs = null;
            st = conn.createStatement();
            rs = st.executeQuery("SELECT COUNT(*) FROM articulo_tipo WHERE articulo_tipo_descripcion = '" + tipoArt + "'");
            rs.next();
            valor = rs.getString(1);
            rs.close();
            st.close();
        } catch (Exception e) {
            out.print("error PSQL" + e);
        }
        Integer aux = Integer.parseInt(valor);
        if (aux != 0) {
            out.println("0");
        } else {
            try {
                Statement st = null;
                st = conn.createStatement();
                st.executeUpdate("insert into articulo_tipo (articulo_tipo_descripcion) values ('" + tipoArt + "')");
                out.println("1");
                st.close();
            } catch (Exception e) {
                out.print("error PSQL" + e);
            }
        }
    }

    if (request.getParameter("listar").equals("modificar")) {
        String pk = request.getParameter("pk");
        String tipoArt = request.getParameter("tipoArt");
        tipoArt = tipoArt.toUpperCase();
        String valor = null;
        try {
            Statement st = null;
            st = conn.createStatement();
            st.executeUpdate("update articulo_tipo set articulo_tipo_descripcion='" + tipoArt + "' where articulo_tipo_id= '" + pk + "' ");
            out.println("2");
            st.close();
        } catch (Exception e) {
            out.print("error PSQL" + e);
        }
    }

    if (request.getParameter("listar").equals("eliminar")) {
        String pk = request.getParameter("pkdel");
        try {
            Statement st = null;
            st = conn.createStatement();
            st.executeUpdate("UPDATE articulo_tipo SET articulo_tipo_estado = 'INACTIVO' where articulo_tipo_id = '" + pk + "'");
            out.println("3");
            st.close();
        } catch (Exception e) {
            out.print("error PSQL" + e);
        }
    }
%>