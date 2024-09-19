<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit Subject</title>
    <style>
        form {
            width: 50%;
            margin: 20px auto;
        }
        
        label, input {
            display: block;
            margin: 10px 0;
        }

        input[type="submit"] {
            padding: 10px;
            background-color: blue;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: darkblue;
        }
    </style>

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




    <h2>Edit Subject</h2>

    <%
        // Get subjectID from the request
        String subjectID = request.getParameter("subjectID");

        // Initialize variables
        String subjectName = "";
        String subjectDescription = "";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Establish database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinequizapp","root","Sandhya@123");

            // Fetch the existing subject details
            String selectSQL = "SELECT Subject_Name, Description FROM subject WHERE Subject_ID = ?";
            pstmt = conn.prepareStatement(selectSQL);
            pstmt.setInt(1, Integer.parseInt(subjectID));
            rs = pstmt.executeQuery();

            if (rs.next()) {
                subjectName = rs.getString("Subject_Name");
                subjectDescription = rs.getString("subjectDescription");
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    %>

    <!-- Edit Subject Form -->
    <form action="UpdateSubject.jsp" method="POST">
        <input type="hidden" name="subjectID" value="<%= subjectID %>" />

        <label for="subjectName">Subject Name:</label>
        <input type="text" id="subjectName" name="subjectName" value="<%= subjectName %>" required />

        <label for="subjectName">Subject Description:</label>
        <input type="text" id="subjectDescription" name="subjectDescription" value="<%= subjectDescription %>" required />
        <br>

        <input type="submit" value="Update Subject" />
    </form>
</body>
</html>