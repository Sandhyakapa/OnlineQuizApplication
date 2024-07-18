<%@ page import="java.sql.*, java.util.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="QuizApp.*" %><!DOCTYPE html>
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
    <style>
        .container {
            margin-top: 50px;
        }
        .quiz-details {
            margin-bottom: 20px;
        }
        .quiz-details .row {
            padding: 10px 0;
            border-bottom: 1px solid #ddd;
        }
        .quiz-details .row:last-child {
            border-bottom: none;
        }
        .questions-container {
            margin: 20px 0;
        }
        .question {
            margin-bottom: 30px;
            padding: 20px;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .question-number {
            font-weight: bold;
            font-size: 18px;
            color: #333;
        }
        .question-text {
            font-size: 16px;
            margin: 10px 0;
            color: #555;
        }
        .option {
            font-size: 14px;
            margin: 5px 0;
            color: #666;
        }
        .correct-answer {
            color: green;
            font-weight: bold;
        }
        .btn-back {
            background-color: #007bff;
            color: #fff;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 5px;
        }
        .btn-back:hover {
            background-color: #0056b3;
        }
    </style>
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
                <h1 class="m-0 text-primary"><i class="fa fa-book-reader me-3"></i>Online Quiz Application</h1>
            </a>
            <button type="button" class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <div class="navbar-nav mx-auto">
                    <a href="../index.html" class="nav-item nav-link">Home</a>
                    <a href="../about.html" class="nav-item nav-link">About Us</a>
                    <a href="contact.html" class="nav-item nav-link">Contact Us</a>
                </div>
                <div class="nav-item dropdown">
                    <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Login</a>
                    <div class="dropdown-menu rounded-0 rounded-bottom border-0 shadow-sm m-0">
                        <a href="Student/Login.html" class="dropdown-item">As Student</a>
                        <a href="" class="dropdown-item">As Faculty</a>
                    </div>
                </div>
            </div>
        </nav>
        <!-- Navbar End -->

        <div class="container">
            <h2 class="text-center">View Quiz</h2>
            <div class="quiz-details">
                <div class="row">
                    <div class="col-md-4"><strong>Quiz ID:</strong></div>
                    <div class="col-md-8"><%= quizId %></div>
                </div>
                <div class="row">
                    <div class="col-md-4"><strong>Subject:</strong></div>
                    <div class="col-md-8"><%= quiz.Subject %></div>
                </div>
                <div class="row">
                    <div class="col-md-4"><strong>Start Date:</strong></div>
                    <div class="col-md-8"><%= quiz.Start_date %></div>
                </div>
                <div class="row">
                    <div class="col-md-4"><strong>End Date:</strong></div>
                    <div class="col-md-8"><%= quiz.end_date %></div>
                </div>
                <div class="row">
                    <div class="col-md-4"><strong>Duration:</strong></div>
                    <div class="col-md-8"><%= quiz.duration %> minutes</div>
                </div>
                <div class="row">
                    <div class="col-md-4"><strong>Total Questions:</strong></div>
                    <div class="col-md-8"><%= quiz.Total_Questions %></div>
                </div>
                <div class="row">
                    <div class="col-md-4"><strong>Created By:</strong></div>
                    <div class="col-md-8"><%= session.getAttribute("facultyName") %></div>
                </div>
            </div>

            <div class="questions-container">
                <h3 class="text-center">Questions</h3>
                <% for (int i = 0; i < questions.size(); i++) {
                    Question question = questions.get(i); %>
                    <div class="question">
                        <p class="question-number">Question <%= i + 1 %>:</p>
                        <p class="question-text"><%= question.question %></p>
                        <p class="option"><strong>A:</strong> <%= question.Option_A %></p>
                        <p class="option"><strong>B:</strong> <%= question.Option_B %></p>
                        <p class="option"><strong>C:</strong> <%= question.Option_C %></p>
                        <p class="option"><strong>D:</strong> <%= question.Option_D %></p>
                        <p class="correct-answer"><strong>Correct Answer:</strong> <%= question.Correct_Answer %></p>
                    </div>
                <% } %>
            </div>
            
            <div class="text-center">
                <a href="facultyDashboard.jsp" class="btn-back">Back to Dashboard</a>
            </div>
        </div>
    </div>

    <!-- Footer Start -->
    <!-- Footer End -->

    <!-- Back to Top -->
    <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>

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
