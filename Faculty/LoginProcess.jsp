<html>
<head>
    <link href="../css/style.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
</head>
<body>
<%@ page import="java.sql.*" %>
<%
    String email = request.getParameter("Email");
    String password = request.getParameter("PassWord");

    //if (email != null && password != null) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Establish connection to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinequizapp", "root", "Sandhya@123");

            // Query to validate faculty credentials and check approval status
            String sql =  "SELECT * FROM faculty WHERE Email = ? AND Password = ?";
           // "SELECT FacultyID, Name, Approval_Status FROM faculty WHERE Email = ? AND Password = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            rs = ps.executeQuery();

            if (rs.next()) {

            
                session.setAttribute("facultyId", rs.getInt(1));
                session.setAttribute("facultyEmail",rs.getString(3));
                session.setAttribute("facultyName", rs.getString(2));
                //session.setAttribute("fac_Subject", rs.getString(4));

                int facultyId = rs.getInt("FacultyID");
                String facultyName = rs.getString("Name");

                


                String approvalQuery = "SELECT Subject_ID  FROM faculty_subject WHERE FacultyID = ? AND Approval_Status = 'Approved'";
                ps = conn.prepareStatement(approvalQuery);
                ps.setInt(1, facultyId);
                ResultSet approvalRs = ps.executeQuery();

                if (approvalRs.next()) {
                    // Set session attributes
                    session.setAttribute("FacultyID", facultyId);
                    session.setAttribute("facultyName", facultyName);
    

                    int subject_ID = approvalRs.getInt("Subject_ID");
                    session.setAttribute("subject_ID", subject_ID);


                    // Redirect to the student's home page
                    //out.println("subject_ID");
                    response.sendRedirect("FacultyHome.jsp");

                } else {
                    // faculty is not approved for any subjects
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