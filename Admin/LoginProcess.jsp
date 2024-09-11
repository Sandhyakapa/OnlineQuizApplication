<html>
    <head>
        <link href="../css/style.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
    </head>
    <body>
    
        <%@ page import = "java.sql.*, java.util.*" %>
   <%
   String Email = request.getParameter("Email");

   String Password = request.getParameter("PassWord");



   try{
    //out.println("Email"+Email);
    //out.println("Password"+Password);
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinequizapp","root","Sandhya@123");
    Statement statement = con.createStatement();
    String sql = "select * from admin where Email='"+Email+"' and Password='"+Password+"'";
    //out.println(sql);
    ResultSet rs= statement.executeQuery(sql);
    
    
    if(rs.next())
    {       
        session.setAttribute("AdminId", rs.getInt(1));
        session.setAttribute("AdminName",rs.getString(3));
        session.setAttribute("AdminEmailId", rs.getString(2));
            response.sendRedirect("AdminHome.jsp");

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
