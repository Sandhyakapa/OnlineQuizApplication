<%@ page import="java.sql.*, java.util.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="QuizApp.*" %>
<html>
    <head>
        <link href="../css/style.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
    </head>
</html>

<%
// Database connection details
String jdbcUrl = "jdbc:mysql://localhost:3306/onlinequizapp";
String jdbcUser = "root";
String jdbcPassword = "Sandhya@123"; // Change this to your actual database password

// Get quiz ID from request
String quizIdParam = request.getParameter("quizId");
if (quizIdParam == null) {
    response.sendRedirect("facultyDashboard.jsp");
}
int quizId = Integer.parseInt(quizIdParam);


try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);
        // Fetch quiz details
        String quizQuery = "delete from quiz where Quiz_id=?";
        PreparedStatement quizStmt = conn.prepareStatement(quizQuery);
            quizStmt.setInt(1, quizId);
            int updatedRecords =0;
            updatedRecords =quizStmt.executeUpdate();
           if(updatedRecords > 0)
            {
                %>
                <script>

                Swal.fire({
                    title: 'Deleted!',
                    text: "Quiz with Id : "+<%=quizIdParam%>+ " deleted successfully.",
                    icon: 'success',
                    confirmButtonText: 'OK',
                   
                    customClass: {
                        title: 'my-title',
                        confirmButton: 'custom-confirm-button',
                        cancelButton: 'custom-cancel-button'
                    }
                }).then((result) => {
                    
                     window.location.href = 'ViewAllQuizzes.jsp';
                });
            </script>


          
            <%
        } 
        
        else {
            out.println("<script>alert('Failed to delete quiz '); window.location.href='ViewAllQuizzes.jsp';</script>");
        }

} catch (Exception e) {
    e.printStackTrace();
    out.println("<p>Error accessing the database: " + e.getMessage() + "</p>");
} 

%>