<%@ page import="java.sql.*, java.util.*, javax.servlet.*, javax.servlet.http.*,QuizApp.*" %>
        <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
        <%

        Integer StudentId = (Integer) session.getAttribute("StudentId");
        String StudentName = (String) session.getAttribute("StudentName");
        String StudentEmailId = (String) session.getAttribute("StudentEmailId");
        %>
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
                            <a href="AddSubject.jsp" class="dropdown-item">Add Subject</a>
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
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Manage Enrollments</a>
                        <div class="dropdown-menu rounded-0 rounded-bottom border-0 shadow-sm m-0">
                            <a href="ViewEnrolledCOurses.jsp" class="dropdown-item">View Enrolled Courses</a>
                            <a href="AddNewCourses.jsp" class="dropdown-item">Add new Courses</a>
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
        <div style="text-align: right;padding-right: 30px;font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;font-weight: bold;color: brown;">Welcome, <%= StudentName %></div>
        <div style="text-align: right;padding-right: 30px;font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;font-weight: bold;color: brown;"><%= StudentEmailId %></div>
        <br>
      


    <!-- START -- Copy Your Form HTML code here-->

   
   
        <h1>Subject Enrollment</h1>
    
        <%
            // Fetch the StudentID from session
            String studentID = session.getAttribute("StudentID").toString();
            Connection con = null;
            PreparedStatement pst = null;
            ResultSet rs = null;
    
            try {
                // Database connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinequizapp", "root", "Sandhya@123");
    
                // Query 1: Fetch approved subjects for the student
                String queryApproved = "SELECT s.Subject_ID, s.Subject_Name, s.Description " +
                                       "FROM subject s JOIN student_subject ss ON s.Subject_ID = ss.Subject_ID " +
                                       "WHERE ss.StudentID = ? AND ss.Approval_Status = 'Approved'";
                pst = con.prepareStatement(queryApproved);
                pst.setString(1, studentID);
                rs = pst.executeQuery();
    
                // Display enrolled subjects
                out.println("<h3>Enrolled Subjects</h3>");
                out.println("<table border='1'>");
                out.println("<tr><th>SubjectID</th><th>Subject Name</th><th>Description</th><th>Status</th><th>Un-Enroll</th></tr>");
                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getString("Subject_ID") + "</td>");
                    out.println("<td>" + rs.getString("Subject_Name") + "</td>");
                    out.println("<td>" + rs.getString("Description") + "</td>");
                    out.println("<td>Enrolled</td>");
                    out.println("<td>");
                    out.println("<form action='UnEnrollSubject.jsp' method='POST'>");
                        out.println("<input type='hidden' name='Subject_ID' value='" + rs.getInt("Subject_ID") + "' />");
                        out.println("<input type='submit' value='Un-Enroll' />");
                        out.println("</form>");
                        out.println("</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
    
                // Query 2: Fetch available subjects (not yet enrolled)
                String queryAvailable = "SELECT s.Subject_ID, s.Subject_Name, s.Description " +
                                        "FROM subject s LEFT JOIN student_subject ss " +
                                        "ON s.Subject_ID = ss.Subject_ID AND ss.StudentID = ? " +
                                        "WHERE ss.Subject_ID IS NULL";
                pst = con.prepareStatement(queryAvailable);
                pst.setString(1, studentID);
                rs = pst.executeQuery();
    
                // Display available subjects
                out.println("<h3>Available Subjects to Enroll</h3>");
                out.println("<table border='1'>");
                out.println("<tr><th>SubjectID</th><th>Subject Name</th><th>Description</th><th>Action</th></tr>");
                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getString("Subject_ID") + "</td>");
                    out.println("<td>" + rs.getString("Subject_Name") + "</td>");
                    out.println("<td>" + rs.getString("Description") + "</td>");
                    out.println("<td>");
                    out.println("<form action='EnrollSubject.jsp' method='POST'>");
                    out.println("<input type='hidden' name='Subject_ID' value='" + rs.getInt("Subject_ID") + "' />");
                    out.println("<input type='submit' value='Enroll' />");
                    out.println("</form>");
                    out.println("</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
    
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (pst != null) try { pst.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    
    


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