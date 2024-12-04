
<%@include file="conexion.jsp"%>
<% if (request.getParameter("listar").equals("listar")) {
        try {
            Statement st = null;
            ResultSet rs = null;
            st = conn.createStatement();
            rs = st.executeQuery("select * from personales;");
            while (rs.next()) {
%>
<tr>
    <td>
        <!-- Icono EDITAR -->
        <i class="icon-create text-green iHover" 
           title="Editar registro" 
           onclick="rellenar('<% out.print(rs.getString(1)); %>', '<% out.print(rs.getString(2)); %>', '<% out.print(rs.getString(3)); %>', '<% out.print(rs.getString(4)); %>', '<% out.print(rs.getString(5)); %>')">
        </i>
        <!-- Icono ELIMINAR -->
        <i class="icon-delete_outline text-red iHover" 
           title="Eliminar registro" 
           data-bs-toggle="modal" 
           data-bs-target="#modalDark" 
           onclick="$('#pkdel').val('<% out.print(rs.getString(1)); %>')">
        </i>
        <!-- Icono REPORTE -->
        <i class="icon-picture_as_pdf text-white iHover" 
           title="Abrir reporte" 
           onclick="abrirReporte('<% out.print(rs.getString(1)); %>');">
        </i>
    </td>    
    <td><% out.print(rs.getString(1)); %></td>    
    <td><% out.print(rs.getString(2)); %></td>
    <td><% out.print(rs.getString(3)); %></td>
    <td><% out.print(rs.getString(4)); %></td>    
    <td><% out.print(rs.getString(5)); %></td>    

</tr>
<%
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            out.print("error PSQL" + e);
        }
    } else if (request.getParameter("listar").equals("cargar")) {
        String per_nombre = request.getParameter("per_nombre");
        per_nombre = per_nombre.toUpperCase();
        String per_apellido = request.getParameter("per_apellido");
        per_apellido = per_apellido.toUpperCase();

        String per_ci = request.getParameter("per_ci");
        String per_telefono = request.getParameter("per_telefono");

        try {
            Statement st = null;
            st = conn.createStatement();
            st.executeUpdate("insert into personales ( per_nombre, per_apellido, per_ci, per_telefono) values ('" + per_nombre + "','" + per_apellido + "','" + per_ci + "','" + per_telefono + "')");
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

        String per_nombre = request.getParameter("per_nombre");
        per_nombre = per_nombre.toUpperCase();
        String per_apellido = request.getParameter("per_apellido");
        per_apellido = per_apellido.toUpperCase();

        String per_ci = request.getParameter("per_ci");
        String per_telefono = request.getParameter("per_telefono");

        try {
            Statement st = null;
            st = conn.createStatement();
            st.executeUpdate("update personales set per_nombre ='" + per_nombre + "', per_apellido ='" + per_apellido + "', per_ci ='" + per_ci + "', per_telefono ='" + per_telefono + "' where per_id = '" + pk + "' ");
            out.print("2");
            st.close();
        } catch (SQLException e) {
            if (e.getSQLState().equals("23505")) {
                out.print("0");
            } else {
                out.println("Error PSQL: " + e.getMessage());
            }
        }
    }

    if (request.getParameter("listar").equals("eliminar")) {
        String pk = request.getParameter("pkdel");
        try {
            Statement st = null;
            st = conn.createStatement();
            st.executeUpdate("delete from personales where per_id = '" + pk + "'");
            out.print("3");
            st.close();
        } catch (Exception e) {
            out.print("error PSQL" + e);
        }
    }
%>