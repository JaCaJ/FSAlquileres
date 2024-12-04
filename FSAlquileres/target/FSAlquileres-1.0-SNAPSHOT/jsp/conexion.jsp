<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%
    Connection conn = null;
    Class.forName("org.postgresql.Driver");
    /*windows*/
    //conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/fsalquileres", "postgres", "1");
    conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/fsalquileres", "postgres", "Sapereaud3");
    /*debian*/
    //conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/fsalquileres", "tech0verlord", "Sapereaud3UwU");
    
    
    if(conn != null){
    //out.print("prueba de conexion");
    
    }
%>