

<%@ page import="java.sql.*, java.util.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="QuizApp.*" %><!DOCTYPE html>
<%

Integer facultyId = (Integer) session.getAttribute("facultyId");
String facultyEmail = (String) session.getAttribute("facultyEmail");
String facultyName1 = (String) session.getAttribute("facultyName");
%> 
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
                            <a href="facility.html" class="dropdown-item">View Profile</a>
                            <a href="team.html" class="dropdown-item">Edit Profile</a>
                            <a href="call-to-action.html" class="dropdown-item">Update Profile</a>
                        </div>
                    </div>

                    <a href="Logout.jsp" class="nav-item nav-link">logout</a>
                </div>
              
            </div>
        </nav>
        <!-- Navbar End -->
        <div style="text-align: right;padding-right: 30px;font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;font-weight: bold;color: brown;">Welcome, <%= facultyName1 %></div>
        <div style="text-align: right;padding-right: 30px;font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;font-weight: bold;color: brown;"><%= facultyEmail %></div>
        <br>


    <!-- START -- Copy Your Form HTML code here-->
    <%
    // Database connection details
    String jdbcUrl = "jdbc:mysql://localhost:3306/onlinequizapp";
    String jdbcUser = "root";
    String jdbcPassword = "Sandhya@123"; // Change this to your actual database password

    // Get quiz ID from request
    String quizIdParam = request.getParameter("quizId");
    if (quizIdParam == null) {
        response.sendRedirect("facultyDashboard.jsp");
        return;
    }
    int quizId = Integer.parseInt(quizIdParam);

    Quiz quiz = null;
    List<Question> questions = new ArrayList<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection conn = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword)) {
            // Fetch quiz details
            String quizQuery = "SELECT * FROM quiz WHERE Quiz_id = ?";
            try (PreparedStatement quizStmt = conn.prepareStatement(quizQuery)) {
                quizStmt.setInt(1, quizId);
                ResultSet quizRs = quizStmt.executeQuery();
                if (quizRs.next()) {
                    String subject = quizRs.getString("Subject");
                    String startDate = quizRs.getString("Start_date");
                    String endDate = quizRs.getString("end_date");
                    int duration = quizRs.getInt("Duration");
                    int totalQuestions = quizRs.getInt("Total_Questions");
                    int createdBy = quizRs.getInt("Created_By");

                    // Fetch faculty name
                    String facultyQuery = "SELECT Name FROM faculty WHERE FacultyID = ?";
                    try (PreparedStatement facultyStmt = conn.prepareStatement(facultyQuery)) {
                        facultyStmt.setInt(1, createdBy);
                        ResultSet facultyRs = facultyStmt.executeQuery();
                        String facultyName = "";
                        if (facultyRs.next()) {
                            facultyName = facultyRs.getString("Name");
                        }

                        quiz = new Quiz(quizId, subject, startDate, endDate, "", duration, totalQuestions, createdBy);
                        session.setAttribute("quiz", quiz);
                        session.setAttribute("facultyName", facultyName);
                    }

                    // Fetch quiz questions
                    String questionQuery = "SELECT * FROM question WHERE Quiz_id = ? ORDER BY Question_no";
                    try (PreparedStatement questionStmt = conn.prepareStatement(questionQuery)) {
                        questionStmt.setInt(1, quizId);
                        ResultSet questionRs = questionStmt.executeQuery();
                        while (questionRs.next()) {
                            String questionText = questionRs.getString("Question");
                            String optionA = questionRs.getString("Option_A");
                            String optionB = questionRs.getString("Option_B");
                            String optionC = questionRs.getString("Option_C");
                            String optionD = questionRs.getString("Option_D");
                            char correctAnswer = questionRs.getString("Correct_Answer").charAt(0);

                            Question question = new Question(questionText, optionA, optionB, optionC, optionD, correctAnswer);
                            questions.add(question);
                        }
                    }
                } else {
                    out.println("<p>No quiz found with ID: " + quizId + "</p>");
                }
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<p>Error accessing the database: " + e.getMessage() + "</p>");
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.println("<p>MySQL JDBC Driver not found: " + e.getMessage() + "</p>");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Quiz</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }
        .container {
            width: 100%;
            max-width: 800px;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }
        h2 {
            color: #333;
            text-align: center;
        }
        .quiz-details {
            margin-bottom: 20px;
            text-align: center;
        }
        .quiz-details p {
            font-size: 16px;
            margin: 5px 0;
        }
        .questions-container {
            margin: 20px 0;
        }
        .question {
            margin-bottom: 30px;
            padding: 10px;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
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
        hr {
            border: none; /* Remove default border */
            border-top: 2px solid #000; /* Set line color and thickness */
            margin: 20px 0; /* Add space above and below the line */
        }
        .text-style {
            box-sizing: border-box; /* Include padding and border in the element's total width and height */
            overflow: hidden; /* Hide scrollbars */
            resize: none; /* Prevent manual resizing */
           
        }
    </style>
</head>
<body>
    <div class="container" style = "background-color:  rgb(231, 231, 220);">
        <div><h3  style="text-align: center;font-family:Cambria, Cochin, Georgia, Times, 'Times New Roman', serif">Quiz details</h3></div>
        <div class="row g-3">
            <div class="col-sm-6">
                <div class="form-floating">
                    <input type="text" class="form-control border-0" style ="pointer-events: none;" id="Subject" name="Subject" value="<%= quiz.Subject %>" placeholder="Subject" >
                    <label for="Subject"><b>Subject:</b></label>
                </div>
            </div>

            <div class="col-sm-6">
                <div class="form-floating">
                    <input type="text" class="form-control border-0" style ="pointer-events: none;" id="quizId" name="quizId" value="<%= quiz.Quiz_id %>" placeholder="quizId" >
                    <label for="quizId"><b>Quiz ID:</b></label>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-floating">
                    <input type="date" class="form-control border-0" style ="pointer-events: none;" id="Start_date" name="Start_date" value="<%= quiz.Start_date %>" placeholder="Start Date" >
                    <label for="Start_date"><b>Start Date:</b></label>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-floating">
                    <input type="date" class="form-control border-0" style ="pointer-events: none;" id="end_date" name="end_date" value="<%= quiz.end_date %>" placeholder="End Date" >
                    <label for="end_date"><b>End Date:</b></label>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-floating">
                    <input type="number" class="form-control border-0" style ="pointer-events: none;" id="duration" name="duration" value="<%= quiz.duration %>" placeholder="Duration" >
                    <label for="duration"><b>Duration:</b></label>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-floating">
                    <input type="number" class="form-control border-0" style ="pointer-events: none;" id="Total_Questions" name="Total_Questions" value="<%= quiz.Total_Questions %>" placeholder="Total Questions" >
                    <label for="Total_Questions"><b>Total Questions:</b></label>
                </div>
            </div>
           
        </div>

        <!-- <div class="quiz-details">
            <p style="text-align: center;"><span class="details-label">Quiz ID:</span><span class="details-value"><%= quizId %></span></p>
            <p><span class="details-label">Subject:</span><span class="details-value"><%= quiz.Subject %></span></p>
            <p><span class="details-label">Start Date:</span><span class="details-value"><%= quiz.Start_date %></span></p>
            <p><span class="details-label">End Date:</span><span class="details-value"><%= quiz.end_date %></span></p>
            <p><span class="details-label">Duration:</span><span class="details-value"><%= quiz.duration %> minutes</span></p>
            <p><span class="details-label">Total Questions:</span><span class="details-value"><%= quiz.Total_Questions %></span></p>
            <p><span class="details-label">Created By:</span><span class="details-value"><%= session.getAttribute("facultyName") %></span></p>
        </div> -->

        <div class="questions-container">
            <h3 style="text-align: center;font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;">Questions</h3>
            <% for (int i = 0; i < questions.size(); i++) {
                Question question = questions.get(i); 
                int answerCode = question.Correct_Answer + 16;
                char answer = (char) answerCode;
                 
                %>
                <div class="question">
                    <p class="question-number">Question <%= i + 1 %>:</p>
                    <hr>
                    <p class="question-text" style="color: #170f2d;font-weight: bold;"><%= question.question %></p>
                    <p class="option"><strong>A:</strong> <%= question.Option_A %> 
                    <p class="option"><strong>B:</strong> <%= question.Option_B %></p>
                    <p class="option"><strong>C:</strong> <%= question.Option_C %></p>
                    <p class="option"><strong>D:</strong> <%= question.Option_D %></p>
                    <input type="button" class="btn" style="border: 2px;background-color: #b3d6e3; color: #170f2d;" value="Correct Answer:   <%
                        
                      
                        out.println(Character.toString(answer));
                       
                        %>">
                </div>
            <% } %>
        </div>
       <div style="text-align: right;"> <a href="ViewAllQuizzes.jsp" class="btn btn-lg" style ="background-color: rgb(49, 96, 86); color: white;">View All Quizzes</a></div>
    </div>
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