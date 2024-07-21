<%@ page import = "java.sql.*, java.util.*" %>
   <%
   session.setAttribute("StudentId", null);
        session.setAttribute("StudentName",null);
        session.setAttribute("StudentEmailId", null);
        response.sendRedirect("Login.html");


        %>