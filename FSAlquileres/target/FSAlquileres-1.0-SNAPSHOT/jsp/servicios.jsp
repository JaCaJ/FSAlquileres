
<%@include file="conexion.jsp"%>
<% if (request.getParameter("listar").equals("listar")) {
        try {
            Statement st = null;
            ResultSet rs = null;
            st = conn.createStatement();
            rs = st.executeQuery("select * from servicios WHERE ser_estado = 'ACTIVO' AND NOT ser_id = 1;");
            while (rs.next()) {
%>
<tr>
    <td>
        <!-- Icono EDITAR -->
        <i class="icon-create text-green iHover" 
           title="Editar" 
           onclick="rellenar('<% out.print(rs.getString(1)); %>', '<% out.print(rs.getString(2)); %>', '<% out.print(rs.getString(3)); %>', '<% out.print(rs.getString(4)); %>')">
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
    <td><% out.print(rs.getString(3)); %></td>
    <td><% out.print(rs.getString(4)); %></td>
</tr>
<%
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            out.print("error PSQL" + e);
        }
    } else if (request.getParameter("listar").equals("cargar")) {
        String ser_descripcion = request.getParameter("ser_descripcion");
        ser_descripcion = ser_descripcion.toUpperCase();
        String ser_precio = request.getParameter("ser_precio");
        String ser_existencia = request.getParameter("ser_existencia");
        try {
            Statement st = null;
            st = conn.createStatement();
            st.executeUpdate("insert into servicios (ser_descripcion, ser_precio, ser_existencia) values ('" + ser_descripcion + "','" + ser_precio + "','" + ser_existencia + "')");
            out.println("1");
            st.close();
        } catch (SQLException e) {
            if (e.getSQLState().equals("23505")) {
                out.print("0");
            } else {
                out.println("Error PSQL: " + e.getMessage());
            }
        }
    }
    if (request.getParameter("listar").equals("modificar")) {
        String pk = request.getParameter("pk");
        String ser_descripcion = request.getParameter("ser_descripcion");
        ser_descripcion = ser_descripcion.toUpperCase();
        String ser_precio = request.getParameter("ser_precio");
        String ser_existencia = request.getParameter("ser_existencia");
        try {
            Statement st = null;
            st = conn.createStatement();
            st.executeUpdate("update servicios set ser_descripcion ='" + ser_descripcion + "', ser_precio ='" + ser_precio + "', ser_existencia = '" + ser_existencia + "' where ser_id = '" + pk + "'");
            out.println("2");
            st.close();
        } catch (SQLException e) {
            if (e.getSQLState().equals("23505")) {
                out.print("0");
            } else {
                out.print("Error PSQL: " + e.getMessage());
            }
        }
    }
    if (request.getParameter("listar").equals("eliminar")) {
        String pk = request.getParameter("pkdel");
        try {
            Statement st = null;
            st = conn.createStatement();
            st.executeUpdate("update servicios set ser_estado = 'INACTIVO' WHERE ser_id = '" + pk + "'");
            out.print("3");
            st.close();
        } catch (Exception e) {
            out.print("error PSQL" + e);
        }
    }
%>