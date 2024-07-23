<%@ page import = "java.sql.*, java.util.*" %>
   <%
        session.setAttribute("facultyId", null);
        session.setAttribute("facultyEmail", null);
        session.setAttribute("facultyName", null);
        response.sendRedirect("Login.html");


        %>