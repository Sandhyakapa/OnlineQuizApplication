<%@ page import="java.util.*" %>
<%@ page import="QuizApp.*" %>
<%@ page import = "java.sql.*" %>
<% 

Quiz quiz = (Quiz) session.getAttribute("quiz");
// int currentQuestion = (int) session.getAttribute("currentQuestion");

    // Get the current question from the session
    Integer currentQuestionObj = (Integer) session.getAttribute("currentQuestion");
    int currentQuestion = 0;
    if (currentQuestionObj != null) {
        currentQuestion = currentQuestionObj;
    }


Question q = new Question();
q.question = request.getParameter("Question");
q.Option_A = request.getParameter("Option_A");
q.Option_B = request.getParameter("Option_B");
q.Option_C = request.getParameter("Option_C");
q.Option_D = request.getParameter("Option_D");

String correctAnswerStr = request.getParameter("Correct_Answer");
    q.Correct_Answer = (correctAnswerStr != null && !correctAnswerStr.isEmpty()) ? correctAnswerStr.charAt(0) : null;

quiz.Questions.put(currentQuestion, q);
session.setAttribute("quiz",quiz);

if(currentQuestion < 3)
{
    session.setAttribute("currentQuestion",++currentQuestion);
    response.sendRedirect("CreateQuizWithQuestions.jsp");
}
else
{
    //Code for inserting the data into database
    out.println("Quiz Name: " + quiz.Subject+"::Quiz StartDate:"+quiz.Start_date);
    out.println("Quiz Name: " + quiz.Subject+"::Quiz StartDate:"+quiz.Start_date + "  Duration: " + quiz.duration+"  Total_Questions:"+quiz.Total_Questions);
    //first insert for quiz table

    Connection conn = null;
    PreparedStatement quizPs = null;
    PreparedStatement questionPs = null;
    ResultSet rs = null;
    int res =0;
    try{
        //out.println("Email="+Email);
        Class.forName("com.mysql.cj.jdbc.Driver");
         conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinequizapp","root","Sandhya@123");
        String sql = "insert into quiz(Subject,Start_date, end_date, Duration,Total_Questions) values(?,?,?,?,?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1,quiz.Subject);
        ps.setString(2,quiz.Start_date);
        ps.setString(3,quiz.end_date);
        ps.setInt(4,quiz.duration);
        ps.setInt(5,quiz.Total_Questions);
         res = ps.executeUpdate();
    
    }  
    catch(Exception e){
        out.println(e);
    }


    
    for (int key : quiz.Questions.keySet()) {
    
        Question questionObj = quiz.Questions.get(key);
        //out.println("<br/>Question Number: " + key + ", :: \nQuestion :" + questionObj.question+"::\nOptionA :" + questionObj.Option_A + "::\nOptionB :" + questionObj.Option_B+"  ::\nOptionC :" + questionObj.Option_C + "::\nOptionD :" + questionObj.Option_D + "CorrectAnswer"+questionObj.Correct_Answer);

        try{
            
            Class.forName("com.mysql.cj.jdbc.Driver");
             conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinequizapp","root","Sandhya@123");

            //String questionSql = "INSERT INTO questions (Question, Option_A, Option_B, Option_C, Option_D, Correct_Answer) VALUES (?, ?, ?, ?, ?, ?)";
            
            if (res > 0) {
                rs = quizPs.getGeneratedKeys();
                if (rs.next()) {
                    int quizId = rs.getInt(1);
    
            String questionSql = "INSERT INTO questions (Quiz_id, Question_no, Question, Option_A, Option_B, Option_C, Option_D, Correct_Answer) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
             questionPs = conn.prepareStatement(questionSql, Statement.RETURN_GENERATED_KEYS);

            //questionPs.setInt(1, quizId);
                    questionPs.setInt(1, quizId);
                    questionPs.setInt(2, key);
                    questionPs.setString(3, questionObj.question);
                    questionPs.setString(4, questionObj.Option_A);
                    questionPs.setString(5, questionObj.Option_B);
                    questionPs.setString(6, questionObj.Option_C);
                    questionPs.setString(7, questionObj.Option_D);
                    questionPs.setString(8, String.valueOf(questionObj.Correct_Answer));
                    questionPs.executeUpdate();
                }
            }

    

        }
    
    catch(Exception e){
        out.println(e);
    }
    /*finally {
        // Close resources
        try {
            if (rs != null) rs.close();
            if (quizPs != null) quizPs.close();
            if (questionPs != null) questionPs.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            out.println(e);
        }
    }*/
    
    //response.sendRedirect("QuizCreated.jsp");
   
   // if (!response.isCommitted()) {
   //     response.sendRedirect("QuizCreated.jsp");
   // }
    
}
    //response.sendRedirect("QuizCreated.jsp");


 

%>
