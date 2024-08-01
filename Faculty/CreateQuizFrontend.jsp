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
                    <!-- <a href="about.html" class="nav-item nav-link">View Result</a> -->

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
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create Quiz</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f0f0f0;
                margin: 0;
                padding: 20px;
            }
            h1 {
                text-align: center;
                color: #333;
            }
            form {
                max-width: 500px;
                margin: 0 auto;
                background-color: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            .form-group {
                margin-bottom: 15px;
            }
            label {
                font-weight: bold;
                display: block;
                margin-bottom: 5px;
            }
            input[type=text], textarea {
                width: 100%;
                padding: 8px;
                font-size: 16px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
            }
            input[type=button], input[type=submit] {
                background-color: #4CAF50;
                color: white;
                border: none;
                padding: 12px 20px;
                text-decoration: none;
                cursor: pointer;
                border-radius: 4px;
                font-size: 16px;
            }
            input[type=button]:hover, input[type=submit]:hover {
                background-color: #45a049;
            }
        </style>
    </head>
    <body>
        <div><h2  style="text-align: center;font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;">Create Quiz</h2></div>
       <p style="text-align: center;">Provide the Quiz details here and we navigate you to add questions in the following screens.</p>
        <form id="quizForm" action="CreateQuiz.jsp" method="POST">
            <div class="row g-3">
            <div class="form-group">
                <label for="question1">Subject:</label>
                
                <input type="text" id="Subject" name="Subject">
            </div>
            <div class="form-group">
                <label for="question1">Number of Questions:</label>
                <input type="text" id="Total_Questions" name="Total_Questions" >
            </div>
            <div class="form-group">
                <label for="question1">Start Date:</label>
                <input type="text" id="Start_date" name="Start_date" >
            </div>
            <div class="form-group">
                <label for="question1">End Date:</label>
                <input type="text" id="end_date" name="end_date" >
            </div>
            <div class="form-group">
                <label for="question1">Duration:</label>
                <input type="text" id="duration" name="duration" >
            </div>
            
            <!--<input type="submit" value="Create Quiz">-->
            <div class="col-sm-6">
                <!-- <input type="submit" value="Proceed" style="background-color:rgb(69, 207, 96);">  -->
                <div style="text-align: right;"><input type="submit" value="Proceed" class="btn"
                            style="text-align: center;background-color: green;color: white; width: 150px;height: 50px;"></div>
                <!--<button class="btn btn-primary w-50 py-3" type="submit"  style="background-color:rgb(69, 207, 96) ;">Proceed</button>-->
                <!-- <a class="btn btn-primary w-49 py-3"  style="background-color:rgb(87, 213, 83);" href="CreateQuiz.jsp">Proceed</a> -->
                <!-- <a class="btn btn-primary w-49 py-3"  style="float: right;background-color:rgb(207, 66, 73);" href="FacultyHome.jsp">Cancel</a> -->
            </div>  
           
                <div class="col-sm-6">
                    <div style="text-align: left;" ><input type="button" value="Cancel" class="btn"
                            style="text-align: center;background-color: #be6464;color: white; width: 150px;height: 50px;" onclick="window.location.href='FacultyHome.jsp';"></div>
                   
                </div>
            </div>

                
            
            
           
           
        </form>
    </body>

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