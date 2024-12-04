<%@page import="java.math.BigInteger"%>
<%@page import="java.security.MessageDigest"%>
<%@include file="conexion.jsp"%>
<%
HttpSession sesion=request.getSession();
sesion.invalidate();
response.sendRedirect("../index.jsp");
%>
