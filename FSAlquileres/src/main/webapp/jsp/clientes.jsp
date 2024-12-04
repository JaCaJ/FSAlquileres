
<%@include file="conexion.jsp"%>
<% if (request.getParameter("listar").equals("listar")) {
        try {
            Statement st = null;
            ResultSet rs = null;
            st = conn.createStatement();
            rs = st.executeQuery("select * from clientes;");
            while (rs.next()) {
%>
<tr>
    <td>
<i class="icon-create text-green iHover" 
   title="Editar registro" 
   onclick="rellenar('<% out.print(rs.getString(1)); %>', '<% out.print(rs.getString(2)); %>', '<% out.print(rs.getString(3)); %>', '<% out.print(rs.getString(4)); %>', '<% out.print(rs.getString(5)); %>', '<% out.print(rs.getString(6)); %>', '<% out.print(rs.getString(7)); %>')">
</i>
<i class="icon-delete_outline text-red iHover" 
   title="Eliminar registro" 
   data-bs-toggle="modal" 
   data-bs-target="#modalDark" 
   onclick="$('#pkdel').val('<% out.print(rs.getString(1)); %>')">
</i>
<i class="icon-picture_as_pdf text-white iHover" 
   title="Generar reporte" 
   onclick="abrirReporte('<% out.print(rs.getString(1)); %>')">
</i>
    </td>
    <td><% out.print(rs.getString(1)); %></td>    
    <td><% out.print(rs.getString(2)); %></td>
    <td><% out.print(rs.getString(3)); %></td>
    <td><% out.print(rs.getString(4)); %></td>    
    <td><% out.print(rs.getString(5)); %></td>    
    <td><% out.print(rs.getString(6)); %></td>
    <td><% out.print(rs.getString(7)); %></td>
</tr>
<%
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            out.print("error PSQL" + e);
        }
    } else if (request.getParameter("listar").equals("cargar")) {
        String cli_nombre = request.getParameter("cli_nombre");
        cli_nombre = cli_nombre.toUpperCase();
        String cli_apellido = request.getParameter("cli_apellido");
        cli_apellido = cli_apellido.toUpperCase();

        String cli_ci = request.getParameter("cli_ci");
        String cli_telefono = request.getParameter("cli_telefono");

        String cli_direccion_maps = request.getParameter("cli_direccion_maps");
        cli_direccion_maps = cli_direccion_maps.toUpperCase();
        String cli_referencia_direccion = request.getParameter("cli_referencia_direccion");
        cli_referencia_direccion = cli_referencia_direccion.toUpperCase();
        String valor = null;

        try {
            Statement st = null;
            ResultSet rs = null;
            st = conn.createStatement();
            st.executeUpdate("insert into clientes ( cli_nombre, cli_apellido, cli_ci, cli_telefono, cli_direccion_maps, cli_referencia_direccion) values ('" + cli_nombre + "','" + cli_apellido + "','" + cli_ci + "','" + cli_telefono + "','" + cli_direccion_maps + "','" + cli_referencia_direccion + "')");
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

        String cli_nombre = request.getParameter("cli_nombre");
        cli_nombre = cli_nombre.toUpperCase();
        String cli_apellido = request.getParameter("cli_apellido");
        cli_apellido = cli_apellido.toUpperCase();

        String cli_telefono = request.getParameter("cli_telefono");
        String cli_ci = request.getParameter("cli_ci");

        String cli_direccion_maps = request.getParameter("cli_direccion_maps");
        cli_direccion_maps = cli_direccion_maps.toUpperCase();
        String cli_referencia_direccion = request.getParameter("cli_referencia_direccion");
        cli_referencia_direccion = cli_referencia_direccion.toUpperCase();
        try {
            Statement st = null;
            st = conn.createStatement();
            st.executeUpdate("update clientes set cli_nombre ='" + cli_nombre + "', cli_apellido ='" + cli_apellido + "', cli_ci ='" + cli_ci + "', cli_telefono ='" + cli_telefono + "', cli_direccion_maps ='" + cli_direccion_maps + "', cli_referencia_direccion ='" + cli_referencia_direccion + "' where cli_id = '" + pk + "' ");
            out.println("2");
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
            st.executeUpdate("delete from clientes where cli_id = '" + pk + "'");
            out.print("3");
            st.close();
        } catch (Exception e) {
            out.print("error PSQL" + e);
        }
    }
%>