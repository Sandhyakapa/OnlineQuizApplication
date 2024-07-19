<%@ page import="java.sql.*, java.util.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="QuizApp.*" %>
<%





try{
   
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinequizapp","root","Sandhya@123");
 
    String sql ="SELECT count(*) as student_marks FROM question INNER JOIN student_answers ON question.Quiz_id = student_answers.Quiz_id and question.Question_ID = student_answers.Question_ID where question.Quiz_id=? and question.Quiz_id = student_answers.Quiz_id and question.Correct_Answer = student_answers.Selected_Option";
    PreparedStatement quizStmt = con.prepareStatement(sql) ;
    
    int quiz_id = Integer.parseInt(request.getParameter("quiz_id"));
    //out.println(quiz_id);
    quizStmt.setInt(1, quiz_id);
//out.println(sql);
    ResultSet rs= quizStmt.executeQuery();
   int marks= 0;
    if (rs.next()) {
     marks =rs.getInt(1); 
    }
    out.println("Your marks:"+marks);
}
catch(Exception e){
    out.println(e);
}


%>