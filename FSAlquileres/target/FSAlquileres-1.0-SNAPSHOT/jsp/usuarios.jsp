
<%@include file="conexion.jsp"%>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<% if (request.getParameter("listar").equals("listar")) {
        try {
            Statement st = null;
            ResultSet rs = null;

            st = conn.createStatement();
            rs = st.executeQuery("select u.*, per.* from usuarios u inner join personales per on u.usu_per_id_fk = per.per_id WHERE estado = 'ACTIVO';");

            while (rs.next()) {
%>
<input type="hidden" id="fkm" name="fkm" value="<% out.print(rs.getString(5)); %>">
<tr>
    <td>
        <!-- Icono EDITAR -->
        <i class="icon-create text-green iHover" 
           title="Editar" 
           onclick="rellenar('<% out.print(rs.getString(1)); %>', '<% out.print(rs.getString(2)); %>', '<% out.print(rs.getString(4)); %>', '<% out.print(rs.getString(5)); %>', '<% out.print(rs.getString(11)); %>')">
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
    <!--<td> * * * * * </td>-->
    <td><% out.print(rs.getString(4)); %></td>    
    <td><% out.print(rs.getString("per_nombre")); %> | <% out.print(rs.getString("per_ci")); %></td>
</tr>
<%

            }
            rs.close();
            st.close();
        } catch (Exception e) {
            out.print("error PSQL" + e);
        }
    } else if (request.getParameter("listar").equals("cargar")) {
        String usu_nick = request.getParameter("usu_nick");
        //usu_nick = usu_nick.toUpperCase();

        String usu_clave = request.getParameter("usu_clave");
        String clave_cifrada = BCrypt.hashpw(usu_clave, BCrypt.gensalt());

        String usu_rol = request.getParameter("usu_rol");
        usu_rol = usu_rol.toUpperCase();

        String fk = request.getParameter("fk");

        try {
            Statement st = null;
            st = conn.createStatement();
            st.executeUpdate("insert into usuarios ( usu_nick, usu_clave,  usu_rol, usu_per_id_fk) values ('" + usu_nick + "','" + clave_cifrada + "' ,'" + usu_rol + "','" + fk + "')");
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

        String usu_nick = request.getParameter("usu_nick");
        usu_nick = usu_nick.toUpperCase();

        String usu_rol = request.getParameter("usu_rol");
        usu_rol = usu_rol.toUpperCase();

        String fk = request.getParameter("fk");

        try {
            Statement st = null;
            st = conn.createStatement();
            st.executeUpdate("update usuarios set usu_nick ='" + usu_nick + "', usu_rol ='" + usu_rol + "', usu_per_id_fk ='" + fk + "' where usu_id = '" + pk + "' ");
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
            st.executeUpdate("update usuarios set estado = 'INACTIVO' where usu_id = '" + pk + "'");
            out.println("3");
            st.close();
        } catch (Exception e) {
            out.print("error PSQL" + e);
        }
    } else if (request.getParameter("listar").equals("buscarpersonal")) {
        try {
            Statement st = null;
            ResultSet rs = null;
            st = conn.createStatement();
            rs = st.executeQuery("select * from personales order by per_id ASC;");
%>
<option value="0">SELECCIONAR</option>
<%
    while (rs.next()) {
%>
<option value="<% out.print(rs.getString(1)); %>,<% out.print(rs.getString(2)); %>"> 
    <% out.print(rs.getString(2)); %> 
    <% out.print(rs.getString(3)); %>|
    <% out.print(rs.getString(4)); %>
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