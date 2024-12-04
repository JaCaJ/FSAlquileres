
<%@include file="conexion.jsp"%>
<% if (request.getParameter("listar").equals("listar")) {
        try {
            Statement st = null;
            ResultSet rs = null;
            st = conn.createStatement();
            rs = st.executeQuery("SELECT articulos.*, at.articulo_tipo_descripcion FROM articulos INNER JOIN articulo_tipo at ON articulos.articulo_tipo_id = at.articulo_tipo_id WHERE NOT art_id = 1 ORDER BY art_id DESC;");
            while (rs.next()) {
%>
<tr>
    <td>
    <!-- Icono EDITAR -->
    <i class="icon-create text-green iHover" 
       title="Editar" 
       onclick="rellenar('<% out.print(rs.getString(1)); %>', '<% out.print(rs.getString(2)); %>', '<% out.print(rs.getString(3)); %>', '<% out.print(rs.getString(4)); %>', '<% out.print(rs.getString(5)); %>', '<% out.print(rs.getString(6)); %>', '<% out.print(rs.getString(7)); %>')">
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
    <td><% out.print(rs.getString(7));%> <% out.print(rs.getString(2)); %></td>
    <td><% out.print(rs.getString(3)); %></td>
    <td><% out.print(rs.getString(4)); %></td>    
    <td><% out.print(rs.getString(5)); %></td>
<input type="hidden" id="fk" name="fk" value="<% out.print(rs.getString(6)); %>">
</tr>
<%
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            out.print("error PSQL" + e);
        }
    } else if (request.getParameter("listar").equals("cargar")) {
        String art_nombre = request.getParameter("art_nombre");
        art_nombre = art_nombre.toUpperCase();

        String art_precio = request.getParameter("art_precio");

        String art_estado = request.getParameter("art_estado");
        art_estado = art_estado.toUpperCase();

        String art_existencia = request.getParameter("art_existencia");

        String fk = request.getParameter("fk");

        try {
            Statement st = null;
            st = conn.createStatement();
            System.out.println("insert into articulos ( art_nombre, art_precio,  art_estado, art_existencia, articulo_tipo_id) values ('" + art_nombre + "','" + art_precio + "' ,'" + art_estado + "','" + art_existencia + "','" + fk + "')");
            st.executeUpdate("insert into articulos ( art_nombre, art_precio,  art_estado, art_existencia, articulo_tipo_id) values ('" + art_nombre + "','" + art_precio + "' ,'" + art_estado + "','" + art_existencia + "','" + fk + "')");
            out.print("1");
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

        String art_nombre = request.getParameter("art_nombre");
        art_nombre = art_nombre.toUpperCase();

        String art_precio = request.getParameter("art_precio");

        String art_estado = request.getParameter("art_estado");
        art_estado = art_estado.toUpperCase();

        String art_existencia = request.getParameter("art_existencia");

        String fk = request.getParameter("fk");

        try {
            Statement st = null;
            st = conn.createStatement();
            st.executeUpdate("update articulos set art_nombre ='" + art_nombre + "',art_precio = '" + art_precio + "', art_estado ='" + art_estado + "', art_existencia ='" + art_existencia + "', articulo_tipo_id ='" + fk + "' where art_id = '" + pk + "' ");
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
            st.executeUpdate("delete from articulos where art_id = '" + pk + "'");
            out.print("3");
            st.close();
        } catch (Exception e) {
            out.print("error PSQL" + e);
        }
    } else if (request.getParameter("listar").equals("buscarTa")) {
        try {
            Statement st = null;
            ResultSet rs = null;
            st = conn.createStatement();
            rs = st.executeQuery("select * from articulo_tipo WHERE articulo_tipo_estado = 'ACTIVO' AND NOT articulo_tipo_id = 1 order by articulo_tipo_id ASC;");
%>
<option value="0">SELECCIONAR</option>

<%
    while (rs.next()) {
%>
<option value="<% out.print(rs.getString(1)); %>,<% out.print(rs.getString(2)); %>"> 
    <% out.print(rs.getString(2)); %> 
</option>    
<%
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            out.print("error PSQL" + e);
        }
    }
%>