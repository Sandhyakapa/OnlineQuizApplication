<%@ page import="java.sql.*" %>
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
                <a href="ViewResult.jsp" class="nav-item nav-link">View Result</a>

                <div class="nav-item dropdown">
                    <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Profile</a>
                    <div class="dropdown-menu rounded-0 rounded-bottom border-0 shadow-sm m-0">
                        <a href="Profile.jsp" class="dropdown-item">View Profile</a>
                        <a href="EditProfile.jsp" class="dropdown-item">Edit Profile</a>
                        <a href="UpdatePassword.jsp" class="dropdown-item">Update password</a>
                    </div>
                </div>

                <a href="Logout.jsp" class="nav-item nav-link">Logout</a>
            </div>
          
        </div>
    </nav>
        <!-- Navbar End -->

    <title>Quiz Results</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
      
    </style>

    <!-- <h2>Quiz Results</h2> -->
    <div><h2  style="text-align: center;font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;">Quiz Results</h2></div>
    <!-- <title>Quiz Results</title> -->
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        table, th, td {
            border: 0px solid #ddd;
        }
        th, td {
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
       
    </style>
</head>
<body>

    <%
        String quizId = request.getParameter("quizId");
        Integer facultyId = (Integer) session.getAttribute("facultyId");
        //out.println("FacultyId: "+ facultyId);
       // out.println("QuizId"+quizId);

        if (quizId == null || facultyId == null) {
            out.println("Quiz ID or Faculty ID is missing.");
        } else {
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                // Load the JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish the connection
                String url = "jdbc:mysql://localhost:3306/onlinequizapp"; // Replace with your database URL
                String username = "root"; // Replace with your database username
                String password = "Sandhya@123"; // Replace with your database password

                conn = DriverManager.getConnection(url, username, password);

                String sql =  "SELECT quiz.Quiz_id, quiz.Subject, quiz.Start_date, quiz.end_date, quiz.Duration, quiz.Total_Questions, student.StudentID, student.Name AS StudentName, attended_quizzes.marks,attended_quizzes.Attempted_TimeStamp FROM quiz JOIN attended_quizzes ON quiz.Quiz_id = attended_quizzes.Quiz_id JOIN student ON attended_quizzes.StudentID = student.StudentID JOIN faculty ON faculty.FacultyID = quiz.Created_By WHERE faculty.FacultyID = ? AND quiz.Quiz_id = ?";

                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1,facultyId);
                pstmt.setInt(2, Integer.parseInt(quizId));

                rs = pstmt.executeQuery();
                

               // if (!rs.isBeforeFirst()) {
                 //   out.println("No results found for the selected quiz and faculty.");
                //} else { 
    %>
    <table>
        <tr>
            
            <th>S.No</th>
            <th>Quiz Id</th>
            <th>Subject</th>
            <th>Start date</th>
            <th>End date</th>
            <th>Duration</th>
            <th>Total Questions</th>
            <th>Attempted Time</th>
            <th>Student Id</th>
            <th>Student Name</th>
            <th>Marks</th>

            <!-- <th>Student Email</th> -->
            

        </tr>
        <%
            int serialNo = 1;
            while (rs.next()) {
              
        %>
        <tr>
            <td><%= serialNo++ %></td>
            <td><%= rs.getInt("Quiz_id") %></td>
            <td><%= rs.getString("Subject") %></td>
            <td><%= rs.getString("Start_date") %></td>
            <td><%= rs.getString("end_date") %></td>
            <td><%= rs.getInt("Duration") %></td>
            <td><%= rs.getInt("Total_Questions") %></td>
            <td><%= rs.getTimestamp("Attempted_TimeStamp") %></td>
            <td><%= rs.getInt("StudentID") %></td>
            <td><%= rs.getString("StudentName") %></td>
            <td><%= rs.getInt("marks") %></td>
            <!-- <td></td> -->
            
        </tr>
        <%
            }
        %>
    </table>
    <%
              //  }
            } catch (Exception e) {
                out.println(e);
                out.println("Error: " + e.getMessage());
               // e.printStackTrace(out);
            } 
            
            /*finally {
                try {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    //e.printStackTrace(out);
                }
            }*/
        }
    %>
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
