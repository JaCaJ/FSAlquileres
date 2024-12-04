<%@include file="conexion.jsp"%>
<%  Statement st = null;
    ResultSet rs = null;
    if (request.getParameter("listar").equals("buscarusuario")) {
        try {
            st = conn.createStatement();
            rs = st.executeQuery("select * from usuarios order by usu_id ASC;");
%>
<option value="0">TODOS</option>

<%
    while (rs.next()) {
%>
<option value="<% out.print(rs.getString(1)); %>,<% out.print(rs.getString(2)); %>"> 
    <% out.print(rs.getString(2)); %> | 
    <% out.print(rs.getString(4)); %>
</option>    
<%
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            out.print("error PSQL" + e);
        }
    }else if (request.getParameter("listar").equals("buscarcliente")) {
        try {
            st = conn.createStatement();
            rs = st.executeQuery("select * from clientes order by cli_id ASC;");
%>
<option value="0">TODOS</option>

<%
    while (rs.next()) {
%>
<option value="<% out.print(rs.getString(1)); %>,<% out.print(rs.getString(2)); %>"> 
    <% out.print(rs.getString(2)); %> | 
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