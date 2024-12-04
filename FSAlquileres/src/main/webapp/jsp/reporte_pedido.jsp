<%@ page import="net.sf.jasperreports.engine.*" %> 
<%@ page import="java.util.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import="java.sql.*" %> 
<%@ page import="net.sf.jasperreports.engine.util.*" %>
<%@include file="conexion.jsp"%>
<%@ page import="com.fsalquileres.conversor.NumeroALetra" %>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%    try {
        /*INDICAMOS EL LUGAR DONDE SE ENCUENTRA NUESTRO ARCHIVO JASPER*/
        File reportFile = new File(application.getRealPath("reportes/comprobantePedido2.jasper"));
        /**/
        Map parametros = new HashMap();
        
        String aux = request.getParameter("idRep");
        int codigo = Integer.parseInt(aux);
        
        System.out.print(aux);
        
        String aux1 = request.getParameter("montoTotal");
        int mtotal = Integer.parseInt(aux1);
        
        System.out.print(aux1);
        // Convertir el monto total a letras usando la clase NumeroALetra
        String montoEnLetras = NumeroALetra.convertir(mtotal);
        
        parametros.put("codigo", codigo);
        parametros.put("montoEnLetras", montoEnLetras);
        
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