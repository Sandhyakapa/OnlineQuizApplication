<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Online Quiz Application - Preschool Website Template</title>
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
                <a href="StudentHome.jsp" class="nav-item nav-link active">Dashboard</a>
                
                
                <div class="nav-item dropdown">
                    <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Quizzes</a>
                    <div class="dropdown-menu rounded-0 rounded-bottom border-0 shadow-sm m-0">
                        <a href="ViewAllQuizzes.jsp" class="dropdown-item">View/Attempt Quizzes</a>
                    </div>
                </div>
                <a href="about.html" class="nav-item nav-link">View Result</a>

                <div class="nav-item dropdown">
                    <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Profile</a>
                    <div class="dropdown-menu rounded-0 rounded-bottom border-0 shadow-sm m-0">
                        <a href="facility.html" class="dropdown-item">View Profile</a>
                        <a href="team.html" class="dropdown-item">Edit Profile</a>
                        <a href="call-to-action.html" class="dropdown-item">Update Profile</a>
                    </div>
                </div>

                <a href="Logout.jsp" class="nav-item nav-link">Logout</a>
            </div>
          
        </div>
    </nav>
        <!-- Navbar End -->


    <!-- START -- Copy Your Form HTML code here-->


    <%@ page import="java.sql.*, java.util.*, javax.servlet.*, javax.servlet.http.*,QuizApp.*" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
    <%
        String jdbcUrl = "jdbc:mysql://localhost:3306/onlinequizapp";
        String jdbcUser = "root";
        String jdbcPassword = "Sandhya@123"; // Change this to your actual database password
    
        Integer StudentId = (Integer) session.getAttribute("StudentId");
        String StudentEmailId = (String) session.getAttribute("StudentEmailId");
        String StudentName = (String) session.getAttribute("StudentName");
        int recordsCount =0;
        if (StudentId == null) {
            response.sendRedirect("LoginProcess.jsp");
            
        }
    
       List<Quiz> quizzes = new ArrayList();   
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);
                // Fetch quizzes for the faculty
                String quizQuery = "select * from quiz where Quiz_id not  in (select Quiz_id from attended_quizzes where StudentID = ?)";
               PreparedStatement quizStmt = conn.prepareStatement(quizQuery);
               quizStmt.setInt(1,StudentId);
                    ResultSet quizRs = quizStmt.executeQuery();
                    while (quizRs.next()) {
                        Quiz quiz = new Quiz();
                        quiz.Quiz_id =  quizRs.getInt("Quiz_id");
                        quiz.Subject = quizRs.getString("Subject");
                        quiz.Start_date = quizRs.getString("Start_date");
                        quiz.end_date  = quizRs.getString("end_date");
                        quiz.duration = quizRs.getInt("Duration");
                        quiz.Total_Questions = quizRs.getInt("Total_Questions");
                        quizzes.add(quiz);
                    }
    
                    if (quizzes.isEmpty()) {
                        out.println("<p>No quizzes found!!! </p>");
                    }
                   
     
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>MySQL JDBC Driver not found: " + e.getMessage() + "</p>");
        }
    
    %>
    
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Quizzes</title>
        <style>
            table {
                width: 100%;
                border-collapse: collapse;
            }
            table, th, td {
                border: 0px solid black;
            }
            th, td {
                padding: 15px;
                text-align: left;
            }
            th {
                background-color: #f2f2f2;
            }
            .operation-button {
                padding: 5px 10px;
                margin: 2px;
                background-color: #4CAF50;
                color: white;
                border: none;
                cursor: pointer;
            }
            .operation-button.edit {
                background-color: #ff9800;
            }
            .operation-button.delete {
                background-color: #f44336;
            }
        </style>
    </head>
    <body>
        
        <div style="text-align: right;padding-right: 30px;font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;font-weight: bold;color: brown;">Welcome, <%= StudentName %></div>
        <div style="text-align: right;padding-right: 30px;font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;font-weight: bold;color: brown;"><%= StudentEmailId %></div>
        
    
        <h3 style="padding-left: 30px;text-align: center;padding-bottom: 30px;color: #5f94da;">All Quizzes</h3>
        <table>
            <tr>
                <th>S.No</th>
                <th>Quiz ID</th>
                <th>Subject</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Duration (minutes)</th>
                <th>Total Questions</th>
                <th>Actions</th>
            </tr>
            <% for (Quiz quiz : quizzes) { 
                recordsCount++;
                %>
                <tr>
                    <td><%= recordsCount %> </td>
                    <td><%= quiz.Quiz_id %></td>
                    <td><%= quiz.Subject %></td>
                    <td><%= quiz.Start_date %></td>
                    <td><%= quiz.end_date %></td>
                    <td><%= quiz.duration %></td>
                    <td><%= quiz.Total_Questions %></td>
                    <td>
                        <button class="operation-button view" onclick="attemptQuiz(<%= quiz.Quiz_id %>)">Attempt Quiz</button>
                       
                    </td>
                </tr>
            <% } %>
        </table>
    
        <script>
            function attemptQuiz(quizId) {
                window.location.href = 'ViewQuiz.jsp?quizId=' + quizId;
            }
    
            
        </script>
    </body>
    </html>
    


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