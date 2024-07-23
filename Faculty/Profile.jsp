<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%
    // Get the FacultyID from the session
    //Integer facultyID = (Integer) session.getAttribute("FacultyID");
    String facultyName = (String) session.getAttribute("facultyName");
    String facultyEmail = (String) session.getAttribute("facultyEmail");
    Integer facultyID = (Integer) session.getAttribute("facultyId");
    if (facultyID == null) {
        response.sendRedirect("Login.html"); // Redirect to login page if not logged in
        return;
    }

    // Initialize database connection parameters
    String dbURL = "jdbc:mysql://localhost:3306/onlinequizapp";
    String dbUser = "root";
    String dbPass = "Sandhya@123";

    // Initialize variables to store faculty details
    String email = "";
    String name = "";
    String mobileNo = "";
    String address = "";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish the connection
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // Create the SQL query
        String sql = "SELECT Email, Name, Mobile_No, Address FROM faculty WHERE FacultyID = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, facultyID);

        // Execute the query
        rs = stmt.executeQuery();

        // Process the result set
        if (rs.next()) {
            email = rs.getString("Email");
            name = rs.getString("Name");
            mobileNo = rs.getString("Mobile_No");
            address = rs.getString("Address");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close the resources
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
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
                            <a href="call-to-action.html" class="dropdown-item">Update Profile</a>
                        </div>
                    </div>

                    <a href="Logout.jsp" class="nav-item nav-link">logout</a>
                </div>
              
            </div>
        </nav>
        <!-- Navbar End -->    
        <div style="text-align: right;padding-right: 30px;font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;font-weight: bold;color: brown;">Welcome, <%= facultyName %></div>
        <div style="text-align: right;padding-right: 30px;font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;font-weight: bold;color: brown;"><%= facultyEmail %></div>
        <!-- <br> -->
        
    <!-- </head> -->
    <!-- /*<style>
         body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: auto;
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .profile-header {
            text-align: center;
            margin-bottom: 20px;
        }
        .profile-header img {
            border-radius: 50%;
            width: 150px;
            height: 150px;
            object-fit: cover;
            margin-bottom: 10px;
        }
        .profile-header h1 {
            margin: 0;
            color: #333;
        }
        .profile-header p {
            color: #777;
        }
        .profile-details {
            margin-top: 20px;
        }
        .profile-details h2 {
            margin-top: 0;
            border-bottom: 2px solid #f4f4f4;
            padding-bottom: 10px;
            color: #333;
        }
        .profile-details p {
            color: #555;
            line-height: 1.6;
        }
        .profile-details .detail-item {
            margin-bottom: 10px;
        }
        .profile-details .detail-item strong {
            display: inline-block;
            width: 150px;
            color: #333;
        }
        .actions {
            text-align: center;
            margin-top: 20px;
        }
        .actions a {
            text-decoration: none;
            color: #007bff;
            font-size: 16px;
            margin: 0 10px;
        }
        .actions a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="profile-header">
            <img src="../img/about-3.jpg" alt="Profile Picture"> <!-- Placeholder image -->
             <!--<h1><%= name %></h1>
            <p>Faculty Member</p>
        </div>
        <div class="profile-details">
            <h2>Profile Details</h2>
            <div class="detail-item">
                <strong>Email:</strong>
                <span><%= email %></span>
            </div>
            <div class="detail-item">
                <strong>Full Name:</strong>
                <span><%= name %></span>
            </div>
            <div class="detail-item">
                <strong>Mobile No:</strong>
                <span><%= mobileNo %></span>
            </div>
            <div class="detail-item">
                <strong>Address:</strong>
                <span><%= address %></span>
            </div>
        </div>
        <div class="actions">
            <a href="editProfile.jsp">Edit Profile</a> | <a href="logout.jsp">Logout</a>
        </div>
    </div>
</body>
</html> -->

<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f9f9f9;
        margin: 0;
        padding: 20px;
    }
    .container {
        max-width: 800px;
        margin: auto;
        background: #fff;
        padding: 30px;
        border-radius: 15px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    .profile-header {
        text-align: center;
        margin-bottom: 30px;
    }
    .profile-header img {
        border-radius: 50%;
        width: 150px;
        height: 150px;
        object-fit: cover;
        border: 2px solid #5f1f25;
        margin-bottom: 15px;
    }
    .profile-header h1 {
        margin: 0;
        color: #333;
        font-size: 2.5em;
    }
    .profile-header p {
        color: #777;
        font-size: 1.2em;
    }
    .profile-details {
        margin-top: 20px;
    }
    .profile-details h2 {
        margin-top: 0;
        border-bottom: 2px solid #e0e0e0;
        padding-bottom: 10px;
        color: #333;
        font-size: 1.8em;
    }
    .profile-details .detail-item {
        margin-bottom: 15px;
        display: flex;
        align-items: center;
    }
    .profile-details .detail-item strong {
        display: inline-block;
        width: 200px;
        color: #333;
        font-weight: 600;
    }
    .profile-details .detail-item span {
        color: #555;
        font-size: 1.1em;
    }
    .actions {
        text-align: center;
        margin-top: 30px;
    }
    .actions a {
        text-decoration: none;
        font-size: 18px;
        margin: 0 15px;
        padding: 12px 24px;
        border-radius: 8px;
        display: inline-block;
        font-weight: bold;
        transition: all 0.3s ease;
    }
    .actions a.edit {
        background-color: #007bff;
        color: #fff;
        border: 2px solid #007bff;
    }
    .actions a.edit:hover {
        background-color: #0056b3;
        border-color: #0056b3;
        transform: translateY(-2px);
    }
    .actions a.logout {
        background-color: #dc3545;
        color: #fff;
        border: 2px solid #dc3545;
    }
    .actions a.logout:hover {
        background-color: #c82333;
        border-color: #c82333;
        transform: translateY(-2px);
    }
</style>
<!-- </head> -->
<body>
<div class="container">
    <div class="profile-header">
        <img src="../img/Profile3.jpg" alt="Profile Picture"> <!-- Placeholder image -->
        <h1><%= name %></h1>
        <p>Faculty Member</p>
    </div>
    <div class="profile-details">
        <h2>Profile Details</h2>
        <div class="detail-item">
            <strong>Email:</strong>
            <span><%= email %></span>
        </div>
        <div class="detail-item">
            <strong>Full Name:</strong>
            <span><%= name %></span>
        </div>
        <div class="detail-item">
            <strong>Mobile No:</strong>
            <span><%= mobileNo %></span>
        </div>
        <div class="detail-item">
            <strong>Address:</strong>
            <span><%= address %></span>
        </div>
    </div>
    <div class="actions">
        <a href="EditProfile.jsp" class="edit">Edit Profile</a>
        <a href="Logout.jsp" class="logout">Logout</a>
    </div>
</div>
</body>
</html>