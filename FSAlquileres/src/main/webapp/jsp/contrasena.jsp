<%@include file="conexion.jsp"%>
<%@ page import="java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<%
    HttpSession sesion = request.getSession();
    if ("cambio".equals(request.getParameter("listar"))) {
        String contrasenaVieja = request.getParameter("cv");
        String contrasenaNueva = request.getParameter("cn");
        String pk = (String) sesion.getAttribute("id");

        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            String query = "SELECT usu_clave FROM usuarios WHERE usu_id = ?";
            ps = conn.prepareStatement(query);
            //ps.setString(1, pk);
            ps.setInt(1, Integer.parseInt(pk));

            rs = ps.executeQuery();

            if (rs.next()) {
                String contrasenaGuardada = rs.getString("usu_clave");

                // Verificaci�n de la contrase�a vieja con bcrypt
                if (BCrypt.checkpw(contrasenaVieja, contrasenaGuardada)) {
                    // La contrase�a antigua es correcta, actualizar con la nueva cifrada
                    String contrasenaNuevaCifrada = BCrypt.hashpw(contrasenaNueva, BCrypt.gensalt());

                    query = "UPDATE usuarios SET usu_clave = ? WHERE usu_id = ?";
                    ps = conn.prepareStatement(query);
                    ps.setString(1, contrasenaNuevaCifrada);
                    //ps.setString(2, pk);
                    ps.setInt(2, Integer.parseInt(pk));


                    int filasActualizadas = ps.executeUpdate();
                    if (filasActualizadas > 0) {
                        out.println("Contrase�a actualizada correctamente");
                    } else {
                        out.println("Error al actualizar la contrase�a");
                    }
                } else {
                    out.println("La contrase�a antigua es incorrecta");
                }
            } else {
                out.println("Usuario no encontrado");
            }
        } catch (Exception e) {
            // Loggear el error en lugar de mostrarlo al usuario
            e.printStackTrace();
            out.println("Ocurri� un error al actualizar la contrase�a");
        } finally {
            // Cerrar recursos en el bloque finally
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
%>
