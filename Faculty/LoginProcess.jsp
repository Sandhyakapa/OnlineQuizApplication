<html>
    <head>
        <link href="../css/style.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
    </head>
    <body>
<%@ page import = "java.sql.*" %>
   <%
   String Email = request.getParameter("Email");
   String Password = request.getParameter("PassWord");


   try{
    //out.println("Email"+Email);
    //out.println("Password"+Password);
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinequizapp","root","Sandhya@123");
    Statement statement = con.createStatement();
    String sql = "select * from faculty where Email='"+Email+"' and Password='"+Password+"'";
    //out.println(sql);
    ResultSet rs= statement.executeQuery(sql);
    
    //if(Email.equals(rs.getString(2)) && Password.equals(rs.getString(5))){
        if (rs.next()) {
            int facultyId = rs.getInt("FacultyID");
            String facultyName = rs.getString("Name");
            session.setAttribute("facultyId", facultyId);
            session.setAttribute("facultyEmail", Email);
            session.setAttribute("facultyName", facultyName);
            response.sendRedirect("FacultyHome.jsp");
        } 
    else{
        
        %>

        <script type="text/javascript">
            // JavaScript to display an alert popup

            Swal.fire({
                title: 'Login Failed!',
                text: 'Invalid EmailId or Password, Please try again!!!',
                icon: 'error',
                confirmButtonText : 'Login',
                customClass: {
                    title: 'my-title',
                    content: 'custom-content',                   
                    confirmButton: 'custom-button-error' // Apply custom class here
                                   
                }
            }).then((result) => {
                if (result.isConfirmed) {
                    // Redirect to another page
                    window.location.href = 'Login.html';
                }
            });;
           
        </script>
    <%
}

   }
   catch(Exception e){
    out.println(e);
   }

   %>
</body>
</html>