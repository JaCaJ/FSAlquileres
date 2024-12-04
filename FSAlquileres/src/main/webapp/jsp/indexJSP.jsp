
<%@page import="java.math.BigInteger"%>
<%@page import="java.security.MessageDigest"%>
<%@include file="conexion.jsp"%>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%
    Statement st = null;
    ResultSet rs = null;

    String claveBd = null;
    String user = request.getParameter("usuario");
    String password = request.getParameter("pswrd");
    int intentosFallidos = 0;
    boolean bloqueado = false;
    long tiempoBloqueo = 0;

    try {
        // Primera consulta: verificar intentos fallidos, si está bloqueado y el tiempo de bloqueo
        st = conn.createStatement();
        rs = st.executeQuery("SELECT usu_clave, intentos_fallidos, bloqueado, tiempo_bloqueo FROM usuarios WHERE usu_nick='" + user + "';");

        if (rs.next()) {
            claveBd = rs.getString("usu_clave");
            intentosFallidos = rs.getInt("intentos_fallidos");
            bloqueado = rs.getBoolean("bloqueado");
            tiempoBloqueo = rs.getLong("tiempo_bloqueo");
        } else {
            out.println("<div class=\"alert alert-danger\" role=\"alert\">Usuario no encontrado</div>");
            rs.close();
            st.close();
            return;
        }

        // Verificar si el usuario está bloqueado temporalmente
        long tiempoActual = System.currentTimeMillis();
        int duracionBloqueo = 15 * 60 * 1000; // 15 minutos en milisegundos

        if (bloqueado && (tiempoActual - tiempoBloqueo < duracionBloqueo)) {
            out.println("<div class=\"alert alert-danger\" role=\"alert\">El usuario está temporalmente bloqueado. Inténtelo más tarde.</div>");
            rs.close();
            st.close();
            return;
        } else if (bloqueado && (tiempoActual - tiempoBloqueo >= duracionBloqueo)) {
            // Desbloquear al usuario si el tiempo de bloqueo ha expirado
            st.executeUpdate("UPDATE usuarios SET bloqueado = FALSE, intentos_fallidos = 0, tiempo_bloqueo = 0 WHERE usu_nick='" + user + "';");
            intentosFallidos = 0; // Reiniciar intentos fallidos
            bloqueado = false;
        }

    } catch (Exception e) {
        out.print(e.getMessage());
    }

    // Verificar si la contraseña ingresada coincide con la cifrada
    boolean coincideClave = BCrypt.checkpw(password, claveBd);

    if (coincideClave) {
        // Restablecer el contador de intentos fallidos si la autenticación es exitosa
        st.executeUpdate("UPDATE usuarios SET intentos_fallidos = 0, bloqueado = FALSE, tiempo_bloqueo = 0 WHERE usu_nick='" + user + "';");

        // Crear la sesión del usuario
        HttpSession sesion = request.getSession();

        try {
            // Segunda consulta: obtener información completa del usuario
            rs = st.executeQuery("SELECT * FROM usuarios WHERE usu_nick='" + user + "';");
            
            if (rs.next()) {
                sesion.setAttribute("logueado", "1");
                sesion.setAttribute("user", rs.getString("usu_nick"));
                sesion.setAttribute("id", rs.getString("usu_id"));
                sesion.setAttribute("rol", rs.getString("usu_rol"));
%>
<script>location.href = 'dashboard.jsp'</script>
<%
            } else {
                out.println("<div class=\"alert alert-danger\" role=\"alert\">Usuario no encontrado en la segunda consulta</div>");
            }
            rs.close();
        } catch (Exception e) {
            out.print(e.getMessage());
        }
    } else {
        
        intentosFallidos++;
        int maxIntentos = 5; // Puedes ajustar este valor a tus necesidades

        // Bloquear el usuario si excede el número máximo de intentos
        if (intentosFallidos >= maxIntentos) {
            long nuevoTiempoBloqueo = System.currentTimeMillis();
            st.executeUpdate("UPDATE usuarios SET intentos_fallidos = " + intentosFallidos + ", bloqueado = TRUE, tiempo_bloqueo = " + nuevoTiempoBloqueo + " WHERE usu_nick='" + user + "';");
            out.println("<div class=\"alert alert-danger\" role=\"alert\">Se ha excedido el número máximo de intentos. El usuario está bloqueado por 15 minutos.</div>");
        } else {
            // Actualizar los intentos fallidos en la base de datos
            st.executeUpdate("UPDATE usuarios SET intentos_fallidos = " + intentosFallidos + " WHERE usu_nick='" + user + "';");
            out.println("<div class=\"alert alert-danger\" role=\"alert\">Usuario o contraseña incorrecta. Intentos fallidos: " + intentosFallidos + ".</div>");
        }
    }
    st.close();
%>
