<!DOCTYPE html>
<html lang="en">
<head>
    <link href="../css/style.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
</head>
<body>
    <%@ page import="java.sql.*, java.util.*" %>
    <%
        String email = request.getParameter("Email");
        String password = request.getParameter("PassWord");
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinequizapp", "root", "Sandhya@123");

            // Check if student exists with the given credentials
            String query = "SELECT * FROM student WHERE Email = ? AND Password = ?";
            ps = conn.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);
            rs = ps.executeQuery();

            if (rs.next()) {

                session.setAttribute("StudentId", rs.getInt(1));
                session.setAttribute("StudentName",rs.getString(3));
                session.setAttribute("StudentEmailId", rs.getString(2));
                
                int studentId = rs.getInt("StudentID");
                String studentName = rs.getString("Name");
               

                // Check if the student is approved for at least one subject
                String approvalQuery = "SELECT * FROM student_subject WHERE StudentID = ? AND Approval_Status = 'Approved'";
                ps = conn.prepareStatement(approvalQuery);
                ps.setInt(1, studentId);
                ResultSet approvalRs = ps.executeQuery();

                if (approvalRs.next()) {
                    // Set session attributes
                    session.setAttribute("StudentID", studentId);
                    session.setAttribute("StudentName", studentName);

                    // Redirect to the student's home page
                    response.sendRedirect("StudentHome.jsp");
                } else {
                    // Student is not approved for any subjects
                    out.println("<p>You have not been approved for any subjects yet. Please wait for approval.</p>");
                }
            } else {
                // Invalid credentials
                %>
                <script type="text/javascript">
                    Swal.fire({
                        title: 'Login Failed!',
                        text: 'Invalid EmailId or Password, Please try again!!!',
                        icon: 'error',
                        confirmButtonText: 'Login',
                        customClass: {
                            title: 'my-title',
                            content: 'custom-content',
                            confirmButton: 'custom-button-error'
                        }
                    }).then((result) => {
                        if (result.isConfirmed) {
                            window.location.href = 'Login.html'; // Redirect to login page
                        }
                    });
                </script>
                <%
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>An error occurred: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
            if (ps != null) try { ps.close(); } catch (SQLException ignored) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
        }
    %>
</body>
</html>
