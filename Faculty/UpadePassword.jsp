<%@ page import="java.sql.*, java.util.*, javax.servlet.*, javax.servlet.http.*,QuizApp.*" %>
        <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
        <%

        Integer facultyId = (Integer) session.getAttribute("facultyId");
        String facultyEmail = (String) session.getAttribute("facultyEmail");
        String facultyName = (String) session.getAttribute("facultyName");
        %>
        <!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Online Quiz Application </title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="../img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Inter:wght@600&family=Lobster+Two:wght@700&display=swap" rel="stylesheet">
    
    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="../lib/animate/animate.min.css" rel="stylesheet">
    <link href="../lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="../css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="../css/style.css" rel="stylesheet">
</head>

<body>
    <div class="container-xxl bg-white p-0">
        <!-- Spinner Start -->
        <!-- <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div> -->
        <!-- Spinner End -->


        <!-- Navbar Start -->
        <nav class="navbar navbar-expand-lg bg-white navbar-light sticky-top px-4 px-lg-5 py-lg-0">
            <a href="index.html" class="navbar-brand">
                <h1 class="m-0 text-primary"><i class="fa fa-book-reader me-3"></i>Online Quiz App</h1>
            </a>
            <button type="button" class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <div class="navbar-nav mx-auto">
                    <a href="FacultyHome.jsp" class="nav-item nav-link active">Dashboard</a>
                    
                    
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Manage Quizzes</a>
                        <div class="dropdown-menu rounded-0 rounded-bottom border-0 shadow-sm m-0">
                            <a href="CreateQuizFrontend.jsp" class="dropdown-item">Create Quiz</a>
                            <!-- <a href="EditQuiz.html" class="dropdown-item">Edit Quiz</a>
                            <a href="DeleteQuiz.html" class="dropdown-item">Delete Quiz</a> -->
                            <a href="ViewAllQuizzes.jsp" class="dropdown-item">View All Quizzes</a>
                        </div>
                    </div>
                    <!-- <a href="ViewResult.jsp" class="nav-item nav-link">View Result</a> -->

                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Profile</a>
                        <div class="dropdown-menu rounded-0 rounded-bottom border-0 shadow-sm m-0">
                            <a href="Profile.jsp" class="dropdown-item">View Profile</a>
                            <a href="EditProfile.jsp" class="dropdown-item">Edit Profile</a>
                            <a href="UpadePassword.jsp" class="dropdown-item">Update password</a>
                        </div>
                    </div>

                    <a href="Logout.jsp" class="nav-item nav-link">logout</a>
                </div>
              
            </div>
        </nav>
        <!-- Navbar End -->    
        <div style="text-align: right;padding-right: 30px;font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;font-weight: bold;color: brown;">Welcome, <%= facultyName %></div>
        <div style="text-align: right;padding-right: 30px;font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;font-weight: bold;color: brown;"><%= facultyEmail %></div>
        <br>
        <!-- Navbar End -->


    <!-- START -- Copy Your Form HTML code here-->

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
            background-color: #439c46;
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
            color: brown;
            font-size: 16px;
            font-weight: bold;
            text-align: center;
        }
    </style>
</head>
<body>
    <div><h3  style="text-align: center;font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;">Update Password</h3></div>
    <div class="container" style="width:30%">
        <!-- <h2>Update Password</h2> -->
        
        <%
            String message = "";
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");
            //Integer facultyId = (Integer) session.getAttribute("facultyId");

            if (facultyId == null) {
                message = "User not logged in.";
            } else if ("POST".equalsIgnoreCase(request.getMethod())) {
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    String url = "jdbc:mysql://localhost:3306/onlinequizapp"; // Replace with your DB URL
                    String username = "root"; // Replace with your DB username
                    String password = "Sandhya@123"; // Replace with your DB password
                    conn = DriverManager.getConnection(url, username, password);

                    // Check if the current password is correct
                    String checkPasswordSql = "SELECT Password FROM faculty WHERE FacultyID = ?";
                    pstmt = conn.prepareStatement(checkPasswordSql);
                    pstmt.setInt(1, facultyId);
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
                            String updatePasswordSql = "UPDATE faculty SET Password = ? WHERE FacultyID = ?";
                            pstmt = conn.prepareStatement(updatePasswordSql);
                            pstmt.setString(1, newPassword);
                            pstmt.setInt(2, facultyId);
                            int rowsAffected = pstmt.executeUpdate();

                            if (rowsAffected > 0) {
                                message = "Password updated successfully.";
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
            
            <label for="confirmPassword">Confirm Password:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
            
            <div style="text-align: center"><input type="submit" value="Update Password"></div>
            
        </form>
        <div class="message"><%= message %></div>
    </div>
    <br>
</body>
</html>
