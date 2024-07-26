<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <link href="../css/style.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
    </head>
</html>

<%
    // Retrieve form parameters
    int quizId = Integer.parseInt(request.getParameter("quizId"));
    String subject = request.getParameter("Subject");
    String startDate = request.getParameter("Start_date");
    String endDate = request.getParameter("end_date");
    int duration = Integer.parseInt(request.getParameter("duration"));
    int totalQuestions = Integer.parseInt(request.getParameter("Total_Questions"));

    // Database connection details
    String jdbcUrl = "jdbc:mysql://localhost:3306/onlinequizapp";
    String jdbcUser = "root";
    String jdbcPassword = "Sandhya@123"; // Change this to your actual database password

    Connection conn = null;
    PreparedStatement ps = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);

        // Update quiz details in the database
        String sql = "UPDATE quiz SET Subject = ?, Start_date = ?, end_date = ?, Duration = ?, Total_Questions = ? WHERE Quiz_id = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, subject);
        ps.setString(2, startDate);
        ps.setString(3, endDate);
        ps.setInt(4, duration);
        ps.setInt(5, totalQuestions);
        ps.setInt(6, quizId);

        int rowsUpdated = ps.executeUpdate();

        if (rowsUpdated > 0) {
            %>
            <script type="text/javascript">
                // JavaScript to display an alert popup
    
                Swal.fire({
                    title: 'Updated!',
                    text: 'Quiz details updated successfully.',
                    icon: 'success',
                    confirmButtonText : 'OK',
                    customClass: {
                        title: 'my-title',
                        content: 'custom-content',                   
                        confirmButton: 'custom-button-success' // Apply custom class here
                                       
                    }
                }).then((result) => {
                    if (result.isConfirmed) {
                        // Redirect to another page
                        window.location.href = 'EditQuiz.jsp?quizId=<%=quizId%>';
                    }
                });;
               
            </script>


           <%
        } else {
            %>
            <script type="text/javascript">
                // JavaScript to display an alert popup
    
                Swal.fire({
                    title: 'Update Failed!',
                    text: 'Quiz details update failed.',
                    icon: 'error',
                    confirmButtonText : 'OK',
                    customClass: {
                        title: 'my-title',
                        content: 'custom-content',                   
                        confirmButton: 'custom-button-error' // Apply custom class here
                                       
                    }
                }).then((result) => {
                    if (result.isConfirmed) {
                        // Redirect to another page
                        window.location.href = 'EditQuiz.jsp?quizId=<%=quizId%>';
                    }
                });;
               
            </script>
            <%
            
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<p>Error updating the database: " + e.getMessage() + "</p>");
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.println("<p>MySQL JDBC Driver not found: " + e.getMessage() + "</p>");
    } finally {
        try {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
