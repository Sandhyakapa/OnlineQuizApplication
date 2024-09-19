<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<% 
// Variables for database connection
Connection conn1 = null;
PreparedStatement ps1 = null;
ResultSet rs = null;
List<Map<String, String>> subjects = new ArrayList<>();

try {
    // Load the JDBC driver
    Class.forName("com.mysql.cj.jdbc.Driver");

    // Establish connection (replace with your DB connection details)
    conn1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinequizapp", "root", "Sandhya@123");

    // SQL query to fetch Subject_ID and Subject_Name from the subject table
    String sql = "SELECT Subject_ID, Subject_Name FROM subject";
    ps1 = conn1.prepareStatement(sql);
    rs = ps1.executeQuery();

    // Loop through result set and add subjects to the list
    while (rs.next()) {
        Map<String, String> subject = new HashMap<>();
        subject.put("id", rs.getString("Subject_ID"));
        subject.put("name", rs.getString("Subject_Name"));
        subjects.add(subject);
    }

} catch (Exception e) {
    e.printStackTrace();
} finally {
    // Close connection resources
    if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
    if (ps1 != null) try { ps1.close(); } catch (SQLException ignore) {}
    if (conn1 != null) try { conn1.close(); } catch (SQLException ignore) {}
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
</head>

<body>
    <div class="container-xxl bg-white p-0">
        <!-- Spinner Start -->
       
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


        <!-- Page Header End -->
    
        <!-- Page Header End -->


        <!-- Appointment Start -->
        <div class="container-xxl py-5">
            <div class="container">
                <div class="bg-light rounded">
                    <div class="row g-0">
                        <div class="col-lg-6 wow fadeIn" data-wow-delay="0.1s">
                            <div class="h-100 d-flex flex-column justify-content-center p-5">
                                <h1 class="mb-4">Student Register</h1>
                                <form action = "RegisterProcess.jsp" method ="post" onsubmit="return validateForm()">
                                    <div class="row g-3">
                                        <div class="col-sm-6">
                                            <div class="form-floating">
                                                <input type="text" class="form-control border-0" id="Name" name = "Name" placeholder="Name">
                                                <label for="Name">Name</label>
                                            </div>
                                        </div>

                                        <div class="col-sm-6">
                                            <div class="form-floating">
                                                <input type="text" class="form-control border-0" id="Mobile_No" name="Mobile_No" placeholder="Mobile_No">
                                                <label for="Mobile No">Mobile No</label>
                                            </div>
                                        </div>

                                        <div class="col-sm-6">
                                            <div class="form-floating">
                                                <input type="text" class="form-control border-0"  id="Address" name="Address" placeholder="Address">
                                                <label for="Address">Address</label>
                                            </div>
                                        </div>

                                        <div class="col-sm-6">
                                            <div class="form-floating">
                                                <input type="email" class="form-control border-0" id="Email" name="Email" placeholder="Email">
                                                <label for="Email">Email Address</label>
                                            </div>
                                        </div>

                                        <div class="col-sm-6">

                                        </div>
                                            <label for="Subject_ID">Select Subject:</label>
                                            <select name="Subject_ID" required>
                                                <option value="">-- Select Subject --</option>
                                                <% 
                                                    for (Map<String, String> subject : subjects) { 
                                                        // Display the subject name and use Subject_ID as the value
                                                %>
                                                    <option value="<%= subject.get("id") %>"><%= subject.get("name") %></option>
                                                <% } %>
                                            </select><br>
                                    </div>
                                        <div class="col-sm-6">
                                            <div class="form-floating">
                                                <input type="password" class="form-control border-0" id="PassWord" name="PassWord" placeholder="PassWord">
                                                <label for="PassWord">PassWord</label>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="form-floating">
                                                <input type="password" class="form-control border-0" id="ConfirmPassWord"  name="ConfirmPassWord" placeholder="PassWord">
                                                <label for="Confirm PassWord">Confirm PassWord</label>
                                            </div>
                                        </div>
                                        
                                        <div class="col-sm-12 d-flex justify-content-between">
                                            <button type="submit" class="btn btn-primary py-3">Register</button>
                                            <a href="../index.html" class="btn btn-warning py-3">Cancel</a>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="h-100 position-relative">
                                <img class="position-absolute w-100 h-100 rounded" src="../img/Faculty.jpg" style="object-fit: cover;">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Registration Form End -->

        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            function validateForm() {
                var password = document.getElementById("PassWord").value;
                var confirmPass = document.getElementById("ConfirmPassWord").value;
                if (password !== confirmPass) {
                    alert("Passwords do not match!");
                    return false;
                }
                return true;
            }
        </script>
    </div>
</body>
</html>
