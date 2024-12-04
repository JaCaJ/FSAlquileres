<%@page import="java.text.ParseException"%>
<%@ page import="net.sf.jasperreports.engine.*" %> 
<%@ page import="java.util.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import="java.sql.*" %> 
<%@ page import="net.sf.jasperreports.engine.util.*" %>
<%@include file="conexion.jsp"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%    try {
        /*INDICAMOS EL LUGAR DONDE SE ENCUENTRA NUESTRO ARCHIVO JASPER*/
        File reportFile = new File(application.getRealPath("reportes/reporteCaja.jasper"));
        Map parametros = new HashMap();

        // Definir el formato en que esperas recibir la fecha
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        // Obtener el valor como String
        String fecha_desde_str = request.getParameter("fecha_desde");
        String fecha_hasta_str = request.getParameter("fecha_hasta");

        try {
            // Convertir el String a Date
            Date fecha_desde = dateFormat.parse(fecha_desde_str);
            Date fecha_hasta = dateFormat.parse(fecha_hasta_str);

            // Pasar las fechas convertidas al informe
            parametros.put("fecha_desde", fecha_desde);
            parametros.put("fecha_hasta", fecha_hasta);

            // Formatear nuevamente a String para imprimir en formato legible
            String fecha_desde_formateada = dateFormat.format(fecha_desde);
            String fecha_hasta_formateada = dateFormat.format(fecha_hasta);

            // Imprimir las fechas en formato legible
            System.out.println(fecha_desde_formateada);
            System.out.println(fecha_hasta_formateada);

        } catch (ParseException e) {
            e.printStackTrace();  // Manejar el error si la conversión falla
        }
        String usuarioS = request.getParameter("usuario");
        int usuario = Integer.parseInt(usuarioS);
        parametros.put("usuario", usuario);

        System.out.println(usuario);
        

        byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parametros, conn);
        response.setContentType("application/pdf");
        response.setContentLength(bytes.length);

        ServletOutputStream output = response.getOutputStream();
        response.getOutputStream();
        output.write(bytes, 0, bytes.length);
        output.flush();
        output.close();
    } catch (java.io.FileNotFoundException ex) {
        ex.getMessage();
    }
%>