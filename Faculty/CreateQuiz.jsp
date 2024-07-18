<%@ page import="QuizApp.*" %>
<%@ page import="java.util.*" %>

<% 
Quiz quiz = new Quiz();
quiz.Subject = request.getParameter("Subject");
out.println(request.getParameter("Start_date"));
//quiz.Total_Questions = (int)request.getParameter("Total_Questions");
String Total_QuestionsStr = request.getParameter("Total_Questions");
    int Total_Questions = 0;
    try {
        Total_Questions = Integer.parseInt(Total_QuestionsStr);
    } catch (NumberFormatException e) {
        out.println("Invalid Total_Questions value: " + Total_QuestionsStr);
    }
    quiz.Total_Questions = Total_Questions;

 
 quiz.Start_date = request.getParameter("Start_date");
 quiz.end_date = request.getParameter("end_date");
 //quiz.duration = (int)request.getParameter("duration");
 String durationStr = request.getParameter("duration");
    int duration = 0;
    try {
        duration = Integer.parseInt(durationStr);
    } catch (NumberFormatException e) {
        out.println("Invalid duration value: " + durationStr);
    }
    quiz.duration = duration;

    
    String Created_ByStr = request.getParameter("Created_By");
    int Created_By = 0;
    try {
        Created_By = Integer.parseInt(Created_ByStr);
    } catch (NumberFormatException e) {
        out.println("Invalid duration value: " + Created_ByStr);
    }



 out.println(quiz);
 session.setAttribute("quiz",quiz);
 session.setAttribute("currentQuestion",1);
 response.sendRedirect("CreateQuizWithQuestions.jsp");



%>