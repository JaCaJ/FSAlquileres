<%@page import="java.text.ParseException"%>
<%@ page import="net.sf.jasperreports.engine.*" %> 
<%@ page import="java.util.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import="java.sql.*" %> 
<%@ page import="net.sf.jasperreports.engine.util.*" %>
<%@include file="conexion.jsp"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page import="com.fsalquileres.conversor.NumeroALetra"%>
<%@page import="com.fsalquileres.conversor.Utils"%>


<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%//inicio de generacion del jasper
    try {
        /*INDICAMOS EL LUGAR DONDE SE ENCUENTRA NUESTRO ARCHIVO JASPER*/
        File reportFile = new File(application.getRealPath("reportes/facturaSPedido2.jasper"));

        Map parametros = new HashMap();

        String aux = request.getParameter("factura_actual");
        Integer factura_actual = Integer.parseInt(aux.trim());

        String aux1 = request.getParameter("montoTotal");
        int mtotal = Integer.parseInt(aux1);
        String montoEnLetras = NumeroALetra.convertir(mtotal);

        // Si el monto en letras es mayor a 63 caracteres, lo dividimos en dos partes
        String[] partesMonto = Utils.dividirMontoEnLetras(montoEnLetras, 63);
        //String[] partesMonto = dividirMontoEnLetras(montoEnLetras, 63);

        parametros.put("codigo", factura_actual);
        parametros.put("mtotal", mtotal);        
        parametros.put("montoEnLetras", partesMonto[0]);
        parametros.put("montoEnLetras2", partesMonto[1]);

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