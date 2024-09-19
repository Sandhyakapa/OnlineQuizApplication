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
    
        <!-- Spinner End -->


        
        <!-- Navbar End -->


    <!-- START -- Copy Your Form HTML code here-->

    <title>Approve or Reject Students</title>
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
       
        <!-- Navbar End -->
       

        



        

        
<!-- START -- Copy Your Form HTML code here-->

<body>
<h2>Pending Student Registrations</h2>

    <table border="1">
        <tr>
            <th>Student Name</th>
            <th>Subject Name</th>
            <th>Approval Status</th>
            <th>Action</th>
        </tr>

        <%
            // Database connection setup
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
                // Assuming you have a DataSource or DriverManager setup
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinequizapp", "root", "Sandhya@123");

                // Query to retrieve all pending student subject registrations
                String query = "SELECT ss.StudentID, s.Name AS StudentName, sub.Subject_Name, ss.Approval_Status " +
                               "FROM student_subject ss " +
                               "JOIN student s ON ss.StudentID = s.StudentID " +
                               "JOIN subject sub ON ss.Subject_ID = sub.Subject_ID " +
                               "WHERE ss.Approval_Status = 'Pending'";
                ps = conn.prepareStatement(query);
                rs = ps.executeQuery();

                // Loop through the result set and display in a table
                while (rs.next()) {
                    int studentId = rs.getInt("StudentID");
                    String studentName = rs.getString("StudentName");
                    String subjectName = rs.getString("Subject_Name");
                    String approvalStatus = rs.getString("Approval_Status");

                    // Display each row
                    %>
                    <tr>
                        <td><%= studentName %></td>
                        <td><%= subjectName %></td>
                        <td><%= approvalStatus %></td>
                        <td>
                            <form method="post">
                                <input type="hidden" name="studentId" value="<%= studentId %>"/>
                                <input type="hidden" name="subjectName" value="<%= subjectName %>"/>
                                <button type="submit" name="action" value="approve">Approve</button>
                                <button type="submit" name="action" value="reject">Reject</button>
                            </form>

                        
                        </td>
                    </tr>
                    <%
                }

                // Handle form submission for approval or rejection
                if (request.getMethod().equalsIgnoreCase("POST")) {
                    String action = request.getParameter("action");
                    int studentId = Integer.parseInt(request.getParameter("studentId"));
                    String subjectName = request.getParameter("subjectName");
                    String newStatus = null;

                    if ("approve".equals(action)) {
                        newStatus = "Approved";
                    } else if ("reject".equals(action)) {
                        newStatus = "Rejected";
                    }

                    if (newStatus != null) {
                        // Update the student_subject table with the new approval status
                        String updateQuery = "UPDATE student_subject SET Approval_Status = ? WHERE StudentID = ? AND Subject_ID = (SELECT Subject_ID FROM subject WHERE Subject_Name = ?)";
                        ps = conn.prepareStatement(updateQuery);
                        ps.setString(1, newStatus);
                        ps.setInt(2, studentId);
                        ps.setString(3, subjectName);
                        int rowsUpdated = ps.executeUpdate();

                        if (rowsUpdated > 0) {
                            out.println("<p>Student registration updated successfully.</p>");
                        } else {
                            out.println("<p>Failed to update student registration.</p>");
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
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
    <script src="lib/wow/wow.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="js/main.js"></script>
    <script>
        const sideMenu = document.getElementById('side-menu');
     const openBtn = document.getElementById('open-btn');
     const closeBtn = document.getElementById('close-btn');
     
     openBtn.addEventListener('click', () => {
         sideMenu.classList.add('open');
     });
     
     closeBtn.addEventListener('click', () => {
         sideMenu.classList.remove('open');
     });
             </script>
</body>

</html>