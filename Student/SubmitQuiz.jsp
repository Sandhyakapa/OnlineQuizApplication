<%@ page import="java.sql.*, java.util.*, javax.servlet.*, javax.servlet.http.*,java.io.*" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="org.json.JSONObject" %>
<%@ page import="QuizApp.*" %>
<%@ page import="java.lang.reflect.Type" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.reflect.TypeToken" %>
<%
try{
  
    StringBuilder sb = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
//out.println(sb.toString());
        String jsonString = sb.toString();
        JSONObject jsonObject = new JSONObject(jsonString);
       //out.println(jsonObject);

       Gson gson = new Gson();
       Type mapType = new TypeToken<Map<String, Object>>(){}.getType();
        Map<String, Object> dataMap = gson.fromJson(jsonString, mapType);



        //Read the user given data from AJAX call
       // out.println("Quiz-ID:"+ dataMap.get("QuizID"));
        Map<String,String> map = (Map<String,String>) dataMap.get("SelectedAnswers");
       
    
        

       // out.println("dataMap :"+ map.entrySet());

       
           //for (Map.Entry<String, String> entry : map.entrySet()) {
                   // out.println("Key = "+entry.getKey());
                  //  out.println("Value = "+ entry.getValue());
            //        }

       // Map<String, Object> map = jsonToMap(jsonObject.get("SelectedAnswers"));
            // Print the Map
       //     for (Map.Entry<String, Object> entry : map.entrySet()) {
       //         System.out.println("Entry = "+entry.getKey() + ": " + entry.getValue());
        //    }
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinequizapp","root","Sandhya@123");
 
    String sql = "select Question_ID from question where Quiz_id=?";
    PreparedStatement quizStmt = con.prepareStatement(sql) ;

    String numberStr  =  String.valueOf(dataMap.get("QuizID"));
    if (numberStr.endsWith(".0")) {
        numberStr = numberStr.substring(0, numberStr.length() - 2);
    }
    //out.println("quiz_id1:"+numberStr);

    int quiz_id = Integer.parseInt(numberStr);
    
    //out.println("quiz_id2:"+quiz_id);

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
          
        String strSelectedOption = "rdbQuestion"+ questionId;
        //out.println("strSelectedOption:"+strSelectedOption);
        if(map.containsKey(strSelectedOption)){
            int selectedOption = Integer.parseInt(map.get(strSelectedOption));
            mapStudentSelectedOptions.put(questionId, selectedOption);
        }

     }

     //for(int questionId : mapStudentSelectedOptions.keySet()){
    //    out.println(questionId+":"+mapStudentSelectedOptions.get(questionId));
    // }

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
    e.printStackTrace();
}
     }


    
     //response.sendRedirect("ViewQuizMarks.jsp?quiz_id="+quiz_id);

     //code for fetching marks
     try{
   
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinequizapp","root","Sandhya@123");
     
        sql ="SELECT count(*) as student_marks FROM question INNER JOIN student_answers ON question.Quiz_id = student_answers.Quiz_id and question.Question_ID = student_answers.Question_ID where question.Quiz_id=? and question.Quiz_id = student_answers.Quiz_id and question.Correct_Answer = student_answers.Selected_Option";
         quizStmt = con.prepareStatement(sql) ;
        
         //quiz_id = Integer.parseInt(request.getParameter("quiz_id"));
        //out.println(quiz_id);
        quizStmt.setInt(1, quiz_id);
    //out.println(sql);
         rs= quizStmt.executeQuery();
       int marks= 0;
        if (rs.next()) {
         marks =rs.getInt(1); 
        }
        out.println("Your Marks : "+marks+"/"+listQuestionIds.size());
       // return marks;
    }
    catch(Exception e){
        e.printStackTrace();
        out.println(e);
    }

} catch (Exception e) {
    // Capture the stack trace in a string
    StringWriter sw = new StringWriter();
    PrintWriter pw = new PrintWriter(sw);
    e.printStackTrace(pw);
    String stackTraceString = sw.toString();

    // Output the stack trace string
    out.println("<p>SQL Error: " +stackTraceString + "</p>");
}


%>