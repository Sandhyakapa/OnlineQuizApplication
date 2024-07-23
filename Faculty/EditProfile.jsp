<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String dbURL = "jdbc:mysql://localhost:3306/onlinequizapp";
    String dbUser = "root";
    String dbPass = "Sandhya@123";

    // Fetch FacultyID from session
    Integer facultyID = (Integer) session.getAttribute("facultyId");
    String facultyEmail = (String) session.getAttribute("facultyEmail");
    String facultyName = (String) session.getAttribute("facultyName");

    if (facultyID == null) {
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

            // Query to update faculty details
            String sql = "UPDATE faculty SET Email = ?, Name = ?, Mobile_No = ?, Address = ? WHERE FacultyID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setString(2, name);
            pstmt.setString(3, mobileNo);
            pstmt.setString(4, address);
            pstmt.setInt(5, facultyID);
            int rowsUpdated = pstmt.executeUpdate();

            if (rowsUpdated > 0) {
                out.println("<div class='message success'>Profile updated successfully!</div>");
            } else {
                out.println("<div class='message error'>Profile update failed. No changes made.</div>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<div class='message error'>Error: " + e.getMessage() + "</div>");
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
    }
%>
<!DOCTYPE html>
<html lang="en">
    <meta charset="UTF-8">
    <title>Faculty Profile</title>
    <link rel="stylesheet" type="text/css" href="styles.css">

<head>
    <meta charset="utf-8">
    <title>Online Quiz Application</title>
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
    <!-- <div class="container-xxl bg-white p-0">
        Spinner Start -->
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
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Manage Quiz</a>
                        <div class="dropdown-menu rounded-0 rounded-bottom border-0 shadow-sm m-0">
                            <a href="CreateQuizFrontend.jsp" class="dropdown-item">Create Quiz</a>
                            <!-- <a href="EditQuiz.html" class="dropdown-item">Edit Quiz</a>
                            <a href="DeleteQuiz.html" class="dropdown-item">Delete Quiz</a> -->
                            <a href="ViewAllQuizzes.jsp" class="dropdown-item">View Quiz</a>
                        </div>
                    </div>
                    <a href="about.html" class="nav-item nav-link">View Result</a>

                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Profile</a>
                        <div class="dropdown-menu rounded-0 rounded-bottom border-0 shadow-sm m-0">
                            <a href="Profile.jsp" class="dropdown-item">View Profile</a>
                            <a href="EditProfile.jsp" class="dropdown-item">Edit Profile</a>
                            <a href="UpdatePassword.jsp" class="dropdown-item">Update Profile</a>
                        </div>
                    </div>

                    <a href="Logout.jsp" class="nav-item nav-link">logout</a>
                </div>
              
            </div>
        </nav>

        <!-- Navbar End -->
        <div style="text-align: right;padding-right: 30px;font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;font-weight: bold;color: brown;">Welcome, <%=facultyName%></div>
        <div style="text-align: right;padding-right: 30px;font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;font-weight: bold;color: brown;"><%=facultyEmail%></div>
        <br>
       <!-- Carousel Start -->
       <!-- <div class="container-fluid p-0 mb-5">
        <div class="owl-carousel header-carousel position-relative">
            <div class="owl-carousel-item position-relative">
                <img class="img-fluid" src="../img/StudentHomepage.jpg" alt="">
                <div class="position-absolute top-0 start-0 w-100 h-100 d-flex align-items-center" style="background: rgba(0, 0, 0, .2);">
                    <div class="container">
                        <div class="row justify-content-start">
                            <div class="col-10 col-lg-8">
                                <h1 class="display-2 text-white animated slideInDown mb-4">Welcome, Student</h1>
                                <p class="fs-5 fw-medium text-white mb-4 pb-2">Explore our online quiz application designed to enhance your teaching experience. Create, manage, and share quizzes effortlessly. Empower your students with interactive assessments and track their progress in real-time. Get started today and make learning more engaging and effective!

                                </p>
                                <a href="" class="btn btn-primary rounded-pill py-sm-3 px-sm-5 me-3 animated slideInLeft">Learn More</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
           
        </div>
    </div> 

 <head> -->
    <!-- <meta charset="utf-8">
    <title>Edit Profile</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link href="../css/bootstrap.min.css" rel="stylesheet"> -->
    <style> -->
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
<!-- </head> -->

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
                <div class="message <%= messageType %>">
                    <%= message %>
                </div>
            <% 
                } 
            %>
        </form>
    </div>
</body>

</html>
