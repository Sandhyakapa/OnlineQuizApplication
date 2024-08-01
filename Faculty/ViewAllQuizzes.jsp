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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
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
                            <a href="call-to-action.html" class="dropdown-item">Update Profile</a>
                        </div>
                    </div>

                    <a href="Logout.jsp" class="nav-item nav-link">Logout</a>
                </div>
              
            </div>
        </nav>
        <!-- Navbar End -->
        <div style="text-align: right;padding-right: 30px;font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;font-weight: bold;color: brown;">Welcome, <%= facultyName %></div>
        <div style="text-align: right;padding-right: 30px;font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;font-weight: bold;color: brown;"><%= facultyEmail %></div>
        <br>


    <!-- START -- Copy Your Form HTML code here-->


    
    
    <%
        String jdbcUrl = "jdbc:mysql://localhost:3306/onlinequizapp";
        String jdbcUser = "root";
        String jdbcPassword = "Sandhya@123"; // Change this to your actual database password
    
        //Integer facultyId = (Integer) session.getAttribute("facultyId");
        //String facultyEmail = (String) session.getAttribute("facultyEmail");
       // String facultyName = (String) session.getAttribute("facultyName");
        int recordsCount =0;
        if (facultyId == null) {
            response.sendRedirect("LoginProcess.jsp");
            return;
        }
    
       List<Quiz> quizzes = new ArrayList();   
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword)) {
                // Fetch quizzes for the faculty
                String quizQuery = "SELECT * FROM quiz WHERE Created_By = ?";
                try (PreparedStatement quizStmt = conn.prepareStatement(quizQuery)) {
                    quizStmt.setInt(1, facultyId);
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
                        out.println("<p>No quizzes found for faculty ID: " + facultyId + "</p>");
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
    
        // Handle delete action
        String action = request.getParameter("action");
        String quizId = request.getParameter("quizId");
    
        if ("delete".equals(action) && quizId != null) {
            try (Connection conn = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword)) {
                String deleteQuery = "DELETE FROM quiz WHERE Quiz_id = ?";
                try (PreparedStatement deleteStmt = conn.prepareStatement(deleteQuery)) {
                    deleteStmt.setInt(1, Integer.parseInt(quizId));
                    deleteStmt.executeUpdate();
                    response.sendRedirect("facultyDashboard.jsp");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<p>Error deleting the quiz: " + e.getMessage() + "</p>");
            }
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
            .operation-button.results {
                background-color: #56697d;
            }
        </style>
    </head>
    <body>
        
        <!-- <p style="text-align: right;padding-right: 20px;">Welcome, Faculty: <%= facultyName %></p>
        <p style="text-align: right;padding-right: 20px;">Email: <%= facultyEmail %></p> -->
    
        <div><h3  style="text-align: center;font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;">Your Quizzes</h3></div>
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
                        <button class="operation-button view" onclick="viewQuiz(<%= quiz.Quiz_id %>)">View</button>
                        <button class="operation-button edit" onclick="editQuiz(<%= quiz.Quiz_id %>)">Edit</button>
                        <button class="operation-button delete" onclick="deleteQuiz(<%= quiz.Quiz_id %>)">Delete</button>
                        <button class="operation-button results" onclick="viewStudentResults(<%= quiz.Quiz_id %>)">View Student Results</button>
                    </td>
                </tr>
            <% } %>
        </table>
    
        <script>
            function viewQuiz(quizId) {
                window.location.href = 'ViewQuiz.jsp?quizId=' + quizId;
            }
    
            function editQuiz(quizId) {
                window.location.href = 'EditQuiz.jsp?quizId=' + quizId;
            }
    
            function deleteQuiz(quizId) {

                Swal.fire({
                title: 'Are you sure?',
                html: "You want to delete quiz with Id : "+quizId+",<br>You won\'t be able to revert this!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Yes, delete it!',
                cancelButtonText: 'No, keep it',
                customClass: {
                    title: 'my-title',
                    confirmButton: 'custom-confirm-button',
                    cancelButton: 'custom-cancel-button'
                }
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = 'DeleteQuiz.jsp?quizId=' + quizId;
                } else if (result.dismiss == Swal.DismissReason.cancel) {
                    window.location.href = 'ViewAllQuizzes.jsp';
                }
            });
            }

            function viewStudentResults(quizId) {
                window.location.href = 'ViewResult.jsp?quizId=' + quizId;
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