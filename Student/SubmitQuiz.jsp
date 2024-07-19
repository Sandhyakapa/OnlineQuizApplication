<%@ page import="java.sql.*, java.util.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="QuizApp.*" %>
<%
try{
   
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinequizapp","root","Sandhya@123");
 
    String sql = "select Question_ID from question where Quiz_id=?";
    PreparedStatement quizStmt = con.prepareStatement(sql) ;
    
    int quiz_id = Integer.parseInt(request.getParameter("quiz_id"));
    //out.println(quiz_id);
    quizStmt.setInt(1, quiz_id);

    ResultSet rs= quizStmt.executeQuery();
    List<Integer> listQuestionIds = new ArrayList<>();
    while (rs.next()) {
        listQuestionIds.add(rs.getInt(1));     
    }

    //for(int i: listQuestionIds){
    //    out.println(i);
    //}

    HashMap<Integer, Integer> mapStudentSelectedOptions = new HashMap<>();

    for(int questionId: listQuestionIds){
          
        String strSelectedOption = request.getParameter("rdbQuestion"+ questionId);
        if(strSelectedOption != null){
            int selectedOption = Integer.parseInt(strSelectedOption);
            mapStudentSelectedOptions.put(questionId, selectedOption);
        }

     }

     //for(int questionId : mapStudentSelectedOptions.keySet()){
     //   out.println(questionId+":"+mapStudentSelectedOptions.get(questionId));
     //}

     for(int questionId : mapStudentSelectedOptions.keySet()){
        int selectedAnswer = mapStudentSelectedOptions.get(questionId);

        //Inserting User selected option into student_answers table
       int StudentId = (Integer)session.getAttribute("StudentId");

try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinequizapp","root","Sandhya@123");
     sql = "insert into student_answers(Quiz_id, Question_Id, StudentID, Selected_Option) values(?,?,?,?)";
    PreparedStatement ps = conn.prepareStatement(sql);
    ps.setInt(1,quiz_id);
    ps.setInt(2,questionId);
    ps.setInt(3,StudentId);
    ps.setInt(4,selectedAnswer);

    int res = ps.executeUpdate();

    if(res>0){
       // out.println("Record Insertd  successfully...");
    }
    else{
       // out.println("insertion Failed...");
    }

   

}
catch(Exception e){
    out.println(e);
}
     }


    
     response.sendRedirect("ViewQuizMarks.jsp?quiz_id="+quiz_id);

} catch (Exception e) {
    e.printStackTrace();
    out.println("<p>SQL Error: " + e.getMessage() + "</p>");
}

    
    








/*String str1 = request.getParameter("rdbQuestion34");
if(str1 != null){
    int q1 = Integer.parseInt(str1);
    out.println("q1 = "+q1);
}*/

//int q2 = Integer.parseInt(request.getParameter("rdbQuestion35"));
//int q3 = Integer.parseInt(request.getParameter("rdbQuestion36"));


//out.println("q2 = "+q2);
//out.println("q3 = "+q3);
%>