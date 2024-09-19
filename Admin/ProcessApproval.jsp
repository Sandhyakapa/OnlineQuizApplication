<%@ page import = "java.sql.*" %>

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

    <title>Admin Approval Page</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        .button {
            padding: 5px 10px;
            text-align: center;
        }
    </style>
</head>
<body>

    <title>Admin Approval Page</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        .button {
            padding: 8px 16px;
            text-decoration: none;
            background-color: green;
            color: white;
            border-radius: 5px;
            border: none;
        }
        .button.reject {
            background-color: red;
        }
    </style>
</head>
<body>
    <h2>Pending Faculty Approvals</h2>

    <table>
        <tr>
            <th>Faculty ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Mobile No</th>
            <th>Address</th>
            <th>Subject</th>
            <th>Approval Status</th>
            <th>Actions</th>
        </tr>

        <%
            // Database connection
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                out.println("Attempting to connect to the database...<br>");
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinequizapp","root","Sandhya@123");
                out.println("Database connection established.<br>");
                stmt = conn.createStatement();

                // Query to get pending faculty members with their subjects
                String sql = "SELECT f.FacultyID, f.Name, f.Email, f.Mobile_No, f.Address, sub.Subject_Name, fs.Approval_Status " +
                "FROM faculty_subject fs " +
                "JOIN faculty f ON fs.FacultyID = f.FacultyID " +
                "JOIN subject sub ON fs.Subject_ID = sub.Subject_ID " +
                "WHERE fs.Approval_Status = 'Pending'";

                rs = stmt.executeQuery(sql);

                out.println("Query executed: " + sql + "<br>");
                boolean dataFound = false;

                // Display each faculty member in a table row
                while (rs.next()) {
                    int facultyID = rs.getInt("FacultyID");
                    String name = rs.getString("Name");
                    String email = rs.getString("Email");
                    String mobileNo = rs.getString("Mobile_No");
                    String address = rs.getString("Address");
                    String subjectName = rs.getString("Subject_Name");
                    String approvalStatus = rs.getString("Approval_Status");
        %>
        <tr>
            <td><%= facultyID %></td>
            <td><%= name %></td>
            <td><%= email %></td>
            <td><%= mobileNo %></td>
            <td><%= address %></td>
            <td><%= subjectName %></td>
            <td><%= approvalStatus %></td>
            <td>
                <!-- Approve Button -->
                <form action="ApproveFaculty.jsp" method="post" style="display:inline;">
                    <input type="hidden" name="facultyID" value="<%= facultyID %>">
                    <input type="submit" value="Approve" class="button">
                </form>

                <!-- Reject Button -->
                <form action="RejectFaculty.jsp" method="post" style="display:inline;">
                    <input type="hidden" name="facultyID" value="<%= facultyID %>">
                    <input type="submit" value="Reject" class="button reject">
                </form>
            </td>
        </tr>
        <%
    }
    
    // If no data is found
    if (!dataFound) {
        out.println("<tr><td colspan='8'>No pending approvals.</td></tr>");
    }

} catch (Exception e) {
    e.printStackTrace();
    out.println("Error: " + e.getMessage());
} finally {
    if (rs != null) rs.close();
    if (stmt != null) stmt.close();
    if (conn != null) conn.close();
}
%>
    </table>


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