<%@ page import = "java.sql.*" %>
<% 
String Email = request.getParameter("Email");
String Name = request.getParameter("Name");
String Mobile_No = request.getParameter("Mobile_No");
String PassWord = request.getParameter("PassWord");
String Address = request.getParameter("Address");



try{
    //out.println("Email="+Email);
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinequizapp","root","Sandhya@123");
    String sql = "insert into student(Email, Name, Mobile_No, PassWord, Address) values(?,?,?,?,?)";
    PreparedStatement ps = conn.prepareStatement(sql);
    ps.setString(1,Email);
    ps.setString(2,Name);
    ps.setString(3,Mobile_No);
    ps.setString(4,PassWord);
    ps.setString(5,Address);
    int res = ps.executeUpdate();

    if(res>0){
        out.println("Registration done successfully...");
    }
    else{
        out.println("Registration Failed...");
    }

}
catch(Exception e){
    out.println(e);
}

%>