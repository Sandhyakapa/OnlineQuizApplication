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