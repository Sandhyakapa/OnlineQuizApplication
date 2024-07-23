<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Password</title>
    <style>
        .form-container {
            max-width: 400px;
            margin: auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }
        .form-group button {
            padding: 10px 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .form-group button:hover {
            background-color: #45a049;
        }
        .message {
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #d4edda;
            border-radius: 5px;
            color: #155724;
            background-color: #d4edda;
            font-size: 1.2em;
        }
        .error {
            border: 1px solid #f8d7da;
            background-color: #f8d7da;
            color: #721c24;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Update Password</h2>

        <% 
            String message = (String) session.getAttribute("passwordUpdateMessage");
            String error = (String) session.getAttribute("passwordUpdateError");

            if (message != null) {
                session.removeAttribute("passwordUpdateMessage");
        %>
        <div class="message"><%= message %></div>
        <% 
            } else if (error != null) {
                session.removeAttribute("passwordUpdateError");
        %>
        <div class="message error"><%= error %></div>
        <% 
            } 
        %>

        <form action="updatePassword.jsp" method="post">
            <div class="form-group">
                <label for="currentPassword">Current Password:</label>
                <input type="password" id="currentPassword" name="currentPassword" required>
            </div>
            <div class="form-group">
                <label for="newPassword">New Password:</label>
                <input type="password" id="newPassword" name="newPassword" required>
            </div>
            <div class="form-group">
                <label for="confirmNewPassword">Confirm New Password:</label>
                <input type="password" id="confirmNewPassword" name="confirmNewPassword" required>
            </div>
            <div class="form-group">
                <button type="submit">Update Password</button>
            </div>
        </form>

        <% 
            // Handle form submission
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmNewPassword = request.getParameter("confirmNewPassword");
            String facultyID = (String) session.getAttribute("facultyID");

            if (currentPassword != null && newPassword != null && confirmNewPassword != null && facultyID != null) {
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

                try {
                    // Load database driver and connect
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinequizapp", "root", "Sandhya@123");

                    // Check if the new passwords match
                    if (!newPassword.equals(confirmNewPassword)) {
                        session.setAttribute("passwordUpdateError", "New passwords do not match.");
                    } else {
                        // Retrieve the current password from the database
                        String query = "SELECT Password FROM faculty WHERE FacultyID = ?";
                        stmt = conn.prepareStatement(query);
                        stmt.setInt(1, Integer.parseInt(facultyID));
                        rs = stmt.executeQuery();

                        if (rs.next()) {
                            String storedPassword = rs.getString("Password");

                            // Validate the current password
                            if (storedPassword.equals(currentPassword)) {
                                // Update the password
                                String updateQuery = "UPDATE faculty SET Password = ? WHERE FacultyID = ?";
                                stmt = conn.prepareStatement(updateQuery);
                                stmt.setString(1, newPassword);
                                stmt.setInt(2, Integer.parseInt(facultyID));
                                stmt.executeUpdate();
                                session.setAttribute("passwordUpdateMessage", "Password updated successfully!");
                            } else {
                                session.setAttribute("passwordUpdateError", "Current password is incorrect.");
                            }
                        } else {
                            session.setAttribute("passwordUpdateError", "Faculty not found.");
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    session.setAttribute("passwordUpdateError", "An error occurred while updating the password.");
                } finally {
                    // Clean up resources
                    try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
                    try { if (stmt != null) stmt.close(); } catch (Exception e) { e.printStackTrace(); }
                    try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
                }

                // Redirect to clear form data and show messages
                response.sendRedirect("updatePassword.jsp");
            }
        %>
    </div>
</body>
</html>
