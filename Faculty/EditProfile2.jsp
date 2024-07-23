<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
        <%

        String dbURL = "jdbc:mysql://localhost:3306/onlinequizapp";
        String dbUser = "root";
            String dbPass = "Sandhya@123"; 
           // Fetch FacultyID from session
           
            

            String facultyName = (String) session.getAttribute("facultyName");
    String facultyEmail = (String) session.getAttribute("facultyEmail");
    Integer facultyID = (Integer) session.getAttribute("facultyId");

           // int facultyID = (Integer) session.getAttribute("FacultyID");

            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            String email = "";
            String name = "";
            String mobileNo = "";
            String address = "";

            try {
                // Establish database connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(dbURL,your_db_username, dbPass);
                // Query to fetch faculty details
                String sql = "SELECT Email, Name, Mobile_No, Address FROM faculty WHERE FacultyID = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, facultyID);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    email = rs.getString("Email");
                    name = rs.getString("Name");
                    mobileNo = rs.getString("Mobile_No");
                    address = rs.getString("Address");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("Error: " + e.getMessage());
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
       
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Profile</title>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 900px;
            margin: auto;
            background: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
        }
        .form-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .form-header h1 {
            margin: 0;
            color: #333;
            font-size: 2.8em;
        }
        .form-header p {
            color: #666;
            font-size: 1.1em;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            color: #555;
            font-weight: 500;
            margin-bottom: 8px;
        }
        .form-group input, .form-group textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 1em;
        }
        .form-group textarea {
            resize: vertical;
            height: 120px;
        }
        .actions {
            text-align: center;
            margin-top: 30px;
        }
        .actions button, .actions a {
            text-decoration: none;
            font-size: 16px;
            padding: 12px 24px;
            border-radius: 8px;
            display: inline-block;
            margin: 0 10px;
            transition: background-color 0.3s ease;
        }
        .actions button {
            background-color: #007bff;
            color: #fff;
            border: none;
            cursor: pointer;
            font-weight: bold;
        }
        .actions button:hover {
            background-color: #0056b3;
        }
        .actions a.cancel {
            background-color: #dc3545;
            color: #fff;
            border: none;
        }
        .actions a.cancel:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-header">
            <h1>Edit Profile</h1>
            <p>Update your profile information below</p>
        </div>
        <form action="updateProfile.jsp" method="post">
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
                <textarea id="address" name="address"><%= address %></textarea>
            </div>
            <div class="actions">
                <button type="submit">Save Changes</button>
                <a href="profile.jsp" class="cancel">Cancel</a>
            </div>
        </form>
    </div>
</body>
</html>
