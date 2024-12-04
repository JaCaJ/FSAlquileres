<%@include file="conexion.jsp"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.time.LocalTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%    Statement st = null;
    ResultSet rs = null;
    st = conn.createStatement();
    if (request.getParameter("listar").equals("abrircaja")) {
        Date fecha = new Date();
        SimpleDateFormat formateador = new SimpleDateFormat("dd-MM-yyyy");
        String fechaCaja = formateador.format(fecha);
        LocalTime horaActual = LocalTime.now();
        DateTimeFormatter formato = DateTimeFormatter.ofPattern("HH:mm:ss");
        String horaCaja = horaActual.format(formato);
        String monto_inicial = request.getParameter("montoi");
        String usu = request.getParameter("usu");
        //Integer monto_total = 0;
        String estado = "ABIERTA";
        try {
            st.executeUpdate("INSERT INTO mov_caja (estado, monto_inicial, monto_total, fecha, hora, usuario) VALUES('" + estado + "','" + monto_inicial + "','" + monto_inicial + "','" + fechaCaja + "','" + horaCaja + "','" + usu + "')");
            out.print("Caja abierta exitosamente.");
            st.close();
        } catch (Exception e) {
            out.println("error PSQL" + e);
        }

    } else if (request.getParameter("listar").equals("cerrarcaja")) {
        Date fecha = new Date();
        SimpleDateFormat formateador = new SimpleDateFormat("dd-MM-yyyy");
        String fechaCaja = formateador.format(fecha);
        LocalTime horaActual = LocalTime.now();
        DateTimeFormatter formato = DateTimeFormatter.ofPattern("HH:mm:ss");
        String horaCaja = horaActual.format(formato);
        //Todavía no se que hacer con monto total.
        //para el insert ---> monto_total = '"+monto_total+"',
        //Integer monto_total = 0;
        String usu = request.getParameter("usu");
        Integer aux = Integer.parseInt(usu);
        try {
            st.executeUpdate("UPDATE mov_caja SET estado = 'CERRADA', fecha = '" + fechaCaja + "', hora = '" + horaCaja + "' WHERE estado = 'ABIERTA' AND usuario = '" + aux + "'");
            out.print("Caja cerrada exitosamente.");
        } catch (Exception e) {
            out.print("Error PSQL:" + e);
        }
    } else if (request.getParameter("listar").equals("consultarcaja")) {
        String usu = request.getParameter("usu");
        Integer aux = Integer.parseInt(usu);
        try {
            rs = st.executeQuery("SELECT estado FROM mov_caja WHERE usuario = '" + aux + "' ORDER BY idcaja DESC LIMIT 1;");
            if (rs.next()) {
                out.print(rs.getString(1));
            } else {
                out.print("CERRADA");
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            out.print("Error PSQL" + e);
        }
    }
%>