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

    if (email != null && password != null) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Establish connection to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinequizapp", "root", "Sandhya@123");

            // Query to validate faculty credentials and check approval status
            String sql = "SELECT FacultyID, Name, Approval_Status FROM faculty WHERE Email = ? AND Password = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            rs = ps.executeQuery();

            if (rs.next()) {
                int facultyId = rs.getInt("FacultyID");
                String facultyName = rs.getString("Name");
                String approvalStatus = rs.getString("Approval_Status");

                if ("Approved".equals(approvalStatus)) {
                    // Set session attributes
                    session.setAttribute("facultyId", facultyId);
                    session.setAttribute("facultyEmail", email);
                    session.setAttribute("facultyName", facultyName);

                    // Redirect to faculty home page
                    response.sendRedirect("FacultyHome.jsp");
                } else {
                    // Set an attribute to display an alert message
                    session.setAttribute("loginMessage", "Your account status is: " + approvalStatus + ". Please contact the admin if needed.");
                    response.sendRedirect("Login.html");
                }
            } else {
                // Set an attribute to display an alert message
                session.setAttribute("loginMessage", "Invalid Email or Password. Please try again.");
                response.sendRedirect("Login.html");
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
%>
</body>
</html>
