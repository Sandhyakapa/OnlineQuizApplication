<%@ page import = "java.sql.*" %>
<% 
String Email = request.getParameter("Email");
String Name = request.getParameter("Name");
String Mobile_No = request.getParameter("Mobile_No");
String PassWord = request.getParameter("PassWord");
String Address = request.getParameter("Address");
boolean isExceptionRaised = false;


try{
    //out.println("Email="+Email);
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinequizapp","root","Sandhya@123");
    String sql = "insert into Faculty(Email, Name, Mobile_No, PassWord, Address) values(?,?,?,?,?)";
    PreparedStatement ps = conn.prepareStatement(sql);
    ps.setString(1,Email);
    ps.setString(2,Name);
    ps.setString(3,Mobile_No);
    ps.setString(4,PassWord);
    ps.setString(5,Address);
    int res = ps.executeUpdate();

    

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

if(res>0){
    // out.println("Registration done successfully...");
    %>
    <div>
        <h4 style="font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif; text-align: center;">Your Registration has completed successfully...</h4>
    </div>
    <div>
        <div style = "text-align: center"><a href ="Login.html" class="btn" style ="background-color: rgb(141, 210, 141);color: white;">Login</a></div>
    </div>
    <%
 }
 else{
    // out.println("Registration Failed...");
    %>
     <div>
        <h4 style="font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif; text-align: center;">Your Registration failed...</h4>
    </div>
    <div>
        <div style = "text-align: center"><a href ="Register.html" class="btn" style ="background-color: rgb(217, 78, 78);color: white;">Register again</a></div>
    </div> 
    <%
 }

}
catch(Exception e){
    isExceptionRaised = true;
 //out.println(e);

}

if(isExceptionRaised==true){
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
    <div>
        <h5 style="font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif; text-align: center;">Faculty with email id: <%=Email%> already registered, Please register with another email id</h5>
     </div>
     <div>
        <br>
        <div style = "text-align: center"><a href ="Register.html" class="btn" style ="background-color: rgb(135, 56, 56);color: white;">Register again</a></div>
     </div> 
     <%

}
%>







<!--END -- Copy Your Form HTML code here-->


        <!-- Footer Start -->
        
        <!-- Footer End -->


        <!-- Back to Top -->
       
    

    <!-- JavaScript Libraries -->
   
</body>

</html>
        



        

        
<!-- START -- Copy Your Form HTML code here-->




    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../lib/wow/wow.min.js"></script>
    <script src="../lib/easing/easing.min.js"></script>
    <script src="../lib/waypoints/waypoints.min.js"></script>
    <script src="../lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="../js/main.js"></script>
    <!-- <script>
        const sideMenu = document.getElementById('side-menu');
     const openBtn = document.getElementById('open-btn');
     const closeBtn = document.getElementById('close-btn');
     
     openBtn.addEventListener('click', () => {
         sideMenu.classList.add('open');
     });
     
     closeBtn.addEventListener('click', () => {
         sideMenu.classList.remove('open');
     });
             </script> -->
</body>

</html>