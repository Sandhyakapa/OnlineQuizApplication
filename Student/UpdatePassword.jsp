<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Password</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
        }
        h2 {
            color: #ff6600;
        }
        label {
            display: block;
            margin: 8px 0 4px;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 8px;
            margin: 4px 0 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        input[type="submit"] {
            background-color: #ff6600;
            color: #fff;
            border: none;
            padding: 10px;
            border-radius: 4px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #e65c00;
        }
        .message {
            margin: 12px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Update Password</h2>
        <%
            String message = "";
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");
            Integer studentId = (Integer) session.getAttribute("StudentId");

            if (studentId == null) {
                message = "User not logged in.";
            } else if ("POST".equalsIgnoreCase(request.getMethod())) {
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    String url = "jdbc:mysql://localhost:3306/onlinequizapp";
                    String username = "root";
                    String password = "Sandhya@123"; 
                    conn = DriverManager.getConnection(url, username, password);

                    // Check if the current password is correct
                    String checkPasswordSql = "SELECT Password FROM student WHERE StudentID = ?";
                    pstmt = conn.prepareStatement(checkPasswordSql);
                    pstmt.setInt(1, studentId);
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                        String storedPassword = rs.getString("Password");

                        if (!storedPassword.equals(currentPassword)) {
                            message = "Current password is incorrect.";
                        } else if (newPassword == null || newPassword.isEmpty()) {
                            message = "New password cannot be empty.";
                        } else if (!newPassword.equals(confirmPassword)) {
                            message = "New passwords do not match.";
                        } else {
                            // Update the password
                            String updatePasswordSql = "UPDATE student SET Password = ? WHERE StudentID = ?";
                            pstmt = conn.prepareStatement(updatePasswordSql);
                            pstmt.setString(1, newPassword);
                            pstmt.setInt(2, studentId);
                            int rowsAffected = pstmt.executeUpdate();

                            if (rowsAffected > 0) {
                                message = "Password updated successfully.";
                                response.sendRedirect("StudentHome.jsp");
                            } else {
                                message = "Failed to update the password.";
                            }
                        }
                    } else {
                        message = "User not found.";
                    }
                } catch (Exception e) {
                    message = "Error: " + e.getMessage();
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        message = "Error closing resources: " + e.getMessage();
                    }
                }
            }
        %>
        <form method="post" action="">
            <label for="currentPassword">Current Password:</label>
            <input type="password" id="currentPassword" name="currentPassword" required>
            
            <label for="newPassword">New Password:</label>
            <input type="password" id="newPassword" name="newPassword" required>
            
            <label for="confirmPassword">Confirm New Password:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
            
            <input type="submit" value="Update Password">
        </form>
        <div class="message"><%= message %></div>
    </div>
</body>
</html>
