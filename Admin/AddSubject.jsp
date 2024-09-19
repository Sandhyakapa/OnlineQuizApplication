<%@ page import="java.sql.*, javax.sql.*, javax.naming.*, java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

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
    <div class="container-xxl bg-white p-0">
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
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
                    <a href="AdminHome.jsp" class="nav-item nav-link active">Dashboard</a>
                    
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Course management</a>
                        <div class="dropdown-menu rounded-0 rounded-bottom border-0 shadow-sm m-0">
                            <a href="AddSubject.html" class="dropdown-item">Add Subject</a>
                            <a href="ManageAllSubjects.jsp" class="dropdown-item">Manage All Subjects</a>
                            
                        </div>
                    </div>

                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Student management</a>
                        <div class="dropdown-menu rounded-0 rounded-bottom border-0 shadow-sm m-0">
                            <a href="ApproveStudent.jsp" class="dropdown-item">View & Approve</a>
                        </div>
                    </div>

                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Faculty management</a>
                        <div class="dropdown-menu rounded-0 rounded-bottom border-0 shadow-sm m-0">
                            <a href="ProcessApproval.jsp" class="dropdown-item">Approve Faculty</a>
                            <a href="ManageFaculty.jsp" class="dropdown-item">Manage Faculty</a>
                        </div>
                    </div>

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


    <!-- START -- Copy Your Form HTML code here-->





<!--END -- Copy Your Form HTML code here-->


        <!-- Footer Start -->
        
        <!-- Footer End -->


        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
    </div>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../lib/wow/wow.min.js"></script>
    <script src="../lib/easing/easing.min.js"></script>
    <script src="../lib/waypoints/waypoints.min.js"></script>
    <script src="../lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="../js/main.js"></script>
</body>

</html>

<%
    String subjectName = request.getParameter("subjectName");
    String subjectDescription = request.getParameter("subjectDescription");
    String message = "";

    if (subjectName != null && !subjectName.isEmpty()) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Load the JDBC driver (assuming MySQL here)
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish the database connection
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinequizapp","root","Sandhya@123");

            // Prepare the SQL INSERT query
            //String sql = "INSERT INTO subject (Subject_Name) VALUES (?)";
            String sql = "INSERT INTO subject (Subject_Name, Description) VALUES (?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, subjectName);
            pstmt.setString(2, subjectDescription);

            // Execute the query
            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                // Redirect to avoid form resubmission on refresh
                response.sendRedirect("AddSubject.jsp?success=true");
            } else {
                message = "Failed to add subject!";
            }
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Display success message if redirected back after successful insertion
    if ("true".equals(request.getParameter("success"))) {
        message = "Subject added successfully!";
    }

%>

<!DOCTYPE html>
<html>
<head>
    <title>Add Subject</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .container {
            width: 50%;
            margin: 0 auto;
            padding: 20px;
            background-color: #f4f4f4;
            border-radius: 10px;
            box-shadow: 0px 0px 10px 0px #ccc;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        label {
            font-weight: bold;
            display: block;
            margin-top: 10px;
        }
        input[type="text"], input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        .message {
            text-align: center;
            font-size: 1.1em;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Add New Subject</h2>
        <form action="AddSubject.jsp" method="POST">
            <label for="subjectName">Subject Name:</label>
            <input type="text" id="subjectName" name="subjectName" required>

            <label for="subjectName">Subject Description:</label>
            <input type="text" id="subjectDescription" name="subjectDescription" required>

            <input type="submit" value="Add Subject">
        </form>
        <div class="message">
            <%= message %>
        </div>
    </div>
</body>
</html>
