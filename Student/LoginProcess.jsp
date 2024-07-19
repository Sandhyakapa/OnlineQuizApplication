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
    String sql = "select * from student where Email='"+Email+"' and Password='"+Password+"'";
    //out.println(sql);
    ResultSet rs= statement.executeQuery(sql);
    
    //if(Email.equals(rs.getString(2)) && Password.equals(rs.getString(5))){
    if(rs.next())
    {       
        session.setAttribute("StudentId", rs.getInt(1));
        session.setAttribute("StudentName",rs.getString(3));
        session.setAttribute("StudentEmailId", rs.getString(2));
            response.sendRedirect("StudentHome.jsp");

    }
    else{
        
        %>
        <script type="text/javascript">
            // JavaScript to display an alert popup
            alert("Login Failed, Pleae try again!!!");
           document.location="Login.html";
        </script>
    <%
}

   }
   catch(Exception e){
    out.println(e);
   }

   %>
