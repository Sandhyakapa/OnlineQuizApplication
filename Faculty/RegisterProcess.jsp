<%@ page import = "java.sql.*" %>
<% 
Connection conn = null;
PreparedStatement ps = null;
boolean isExceptionRaised = false;
int FacultyId = 0;  // To hold the generated Faculty ID

String Email = request.getParameter("Email");
String Name = request.getParameter("Name");
String Mobile_No = request.getParameter("Mobile_No");
String PassWord = request.getParameter("PassWord");
String Address = request.getParameter("Address");
String Subject_ID = request.getParameter("Subject_ID");
String Approval_Status = "Pending";  // Default status for approval
int result = 0;

try {
    // Establish connection
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinequizapp", "root", "Sandhya@123");

    // Start a transaction
    conn.setAutoCommit(false);

    // Insert the faculty data into the Faculty table
    String insertQuery = "INSERT INTO Faculty (Email, Name, Mobile_No, PassWord, Address) " +
                         "VALUES (?, ?, ?, ?, ?)";
    ps = conn.prepareStatement(insertQuery, Statement.RETURN_GENERATED_KEYS);
    ps.setString(1, Email);
    ps.setString(2, Name);
    ps.setString(3, Mobile_No);
    ps.setString(4, PassWord);
    ps.setString(5, Address);

    result = ps.executeUpdate();

    // Get the generated Faculty ID
    ResultSet generatedKeys = ps.getGeneratedKeys();
    if (generatedKeys.next()) {
        FacultyId = generatedKeys.getInt(1);  // Get the auto-generated FacultyId
    }

    if (result > 0 && FacultyId > 0) {
        // Insert into the 'faculty_subject' table with 'Pending' approval status
        String subjectSQL = "INSERT INTO faculty_subject (FacultyId, Subject_ID, Approval_Status) VALUES (?, ?, 'Pending')";
        PreparedStatement psSubject = conn.prepareStatement(subjectSQL);
        psSubject.setInt(1, FacultyId);
        psSubject.setString(2, Subject_ID);
        int subjectRes = psSubject.executeUpdate();

        if (subjectRes > 0) {
            // Commit transaction if both inserts are successful
            conn.commit();
        } else {
            // Rollback if subject insertion fails
            conn.rollback();
            result = 0;  // Reset result to indicate failure
        }
    } else {
        // Rollback if Faculty insertion fails
        conn.rollback();
    }
} catch (Exception e) {
    isExceptionRaised = true;
    e.printStackTrace();
    if (conn != null) {
        try {
            conn.rollback();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }
} finally {
    // Close resources
    if (ps != null) ps.close();
    if (conn != null) conn.close();
}
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

    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../lib/wow/wow.min.js"></script>
    <script src="../lib/easing/easing.min.js"></script>
    <script src="../lib/waypoints/waypoints.min.js"></script>
    <script src="../lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="../js/main.js"></script>
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

    </div>
    <!-- START -- Copy Your Form HTML code here-->
<br>
<br>
<%

            if (result > 0) {

                %>
                <div>
                    <h4 style="font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif; text-align: center;">Registration Successful! Your application is under review....</h4>
                </div>
                <div>
                    <div style = "text-align: center"><a href ="Login.html" class="btn" style ="background-color: rgb(141, 210, 141);color: white;">Login</a></div>
                </div>

                <!-- <div>
                    <h4 style="text-align: center;">Your registration has been completed successfully.</h4>
                </div>
                <div style="text-align: center;">
                    <a href="Login.html" class="btn" style="background-color: green; color: white;">Login</a>
                </div> -->
                <%
            } else if (isExceptionRaised) {
                // Exception occurred
            %>
                <div>
                    <h5 style="text-align: center;">Faculty with email id: <%= Email %> is already registered. Please use another email id.</h5>
                </div>
                <div style="text-align: center;">
                    <a href="Register.jsp" class="btn" style="background-color: red; color: white;">Register again</a>
                </div>
            <%
            } else {
                // Registration failed
            %>
                 <div>
                    <h4 style="font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif; text-align: center;">Your Registration failed...</h4>
                </div>
                <div>
                    <div style = "text-align: center"><a href ="Register.html" class="btn" style ="background-color: rgb(217, 78, 78);color: white;">Register again</a></div>
                </div> 
                <%
}
%>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>