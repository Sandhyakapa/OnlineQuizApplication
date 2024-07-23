<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String dbURL = "jdbc:mysql://localhost:3306/onlinequizapp";
    String dbUser = "root";
    String dbPass = "Sandhya@123";

    // Fetch StudentID from session
    Integer studentID = (Integer) session.getAttribute("StudentId");
    String studentEmail = (String) session.getAttribute("StudentEmailId");
    String studentName = (String) session.getAttribute("StudentName");

    if (studentID == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String email = "";
    String name = "";
    String mobileNo = "";
    String address = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        // Get form data
        email = request.getParameter("email");
        name = request.getParameter("name");
        mobileNo = request.getParameter("mobileNo");
        address = request.getParameter("address");

        try {
            // Establish database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            // Query to update student details
            String sql = "UPDATE student SET Email = ?, Name = ?, Mobile_No = ?, Address = ? WHERE StudentID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setString(2, name);
            pstmt.setString(3, mobileNo);
            pstmt.setString(4, address);
            pstmt.setInt(5, studentID);
            int rowsUpdated = pstmt.executeUpdate();

            if (rowsUpdated > 0) {
                request.setAttribute("message", "Profile updated successfully!");
                request.setAttribute("messageType", "success");
            } else {
                request.setAttribute("message", "Profile update failed. No changes made.");
                request.setAttribute("messageType", "error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error: " + e.getMessage());
            request.setAttribute("messageType", "error");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } else {
        try {
            // Establish database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            // Query to fetch student details
            String sql = "SELECT Email, Name, Mobile_No, Address FROM student WHERE StudentID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, studentID);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                email = rs.getString("Email");
                name = rs.getString("Name");
                mobileNo = rs.getString("Mobile_No");
                address = rs.getString("Address");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error: " + e.getMessage());
            request.setAttribute("messageType", "error");
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Edit Profile</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: auto;
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .profile-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .profile-header img {
            border-radius: 50%;
            width: 120px;
            height: 120px;
            object-fit: cover;
            border: 3px solid #007bff;
        }
        .profile-header h1 {
            margin: 10px 0;
            font-size: 24px;
            color: #333;
        }
        .profile-header p {
            color: #555;
        }
        .profile-details {
            margin-top: 20px;
        }
        .profile-details h2 {
            margin-top: 0;
            border-bottom: 2px solid #007bff;
            padding-bottom: 10px;
            color: #333;
            font-size: 22px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            font-weight: 500;
            margin-bottom: 5px;
            color: #333;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            color: #333;
        }
        .form-group input:focus {
            border-color: #007bff;
            outline: none;
            box-shadow: 0 0 0 0.2rem rgba(38, 143, 255, 0.25);
        }
        .actions {
            text-align: center;
            margin-top: 20px;
        }
        .actions button, .actions a {
            text-decoration: none;
            font-size: 16px;
            padding: 12px 24px;
            border-radius: 5px;
            color: #fff;
            border: none;
            cursor: pointer;
            margin: 0 10px;
            display: inline-block;
        }
        .actions button {
            background-color: #007bff;
        }
        .actions button:hover {
            background-color: #0056b3;
        }
        .actions a {
            background-color: #dc3545;
        }
        .actions a:hover {
            background-color: #c82333;
        }
        .message {
            margin-top: 20px;
            padding: 15px;
            border-radius: 5px;
            font-size: 16px;
            text-align: center;
        }
        .message.success {
            color: #28a745;
            border: 1px solid #28a745;
        }
        .message.error {
            color: #dc3545;
            border: 1px solid #dc3545;
        }
    </style>
</head>

<body>
    <div class="container">
        <div class="profile-header">
            <img src="../img/testimonial-1.jpg" alt="Profile Picture"> <!-- Placeholder image -->
            <h1>Edit Profile</h1>
            <p>Update your profile details below.</p>
        </div>
        <form method="post">
            <div class="profile-details">
                <h2>Profile Details</h2>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" value="<%= email %>" required>
                </div>
                <div class="form-group">
                    <label for="name">Full Name:</label>
                    <input type="text" id="name" name="name" value="<%= name %>" required>
                </div>
                <div class="form-group">
                    <label for="mobileNo">Mobile No:</label>
                    <input type="text" id="mobileNo" name="mobileNo" value="<%= mobileNo %>" required>
                </div>
                <div class="form-group">
                    <label for="address">Address:</label>
                    <input type="text" id="address" name="address" value="<%= address %>">
                </div>
            </div>
            <div class="actions">
                <button type="submit" name="update">Update Profile</button>
                <a href="logout.jsp">Logout</a>
            </div>
            <% 
                // Display success or error message
                String message = (String) request.getAttribute("message");
                String messageType = (String) request.getAttribute("messageType"); // "success" or "error"
                if (message != null) { 
            %>
                <div class="message <%= messageType %>"><%= message %></div>
            <% } %>
        </form>
    </div>
</body>

</html>
