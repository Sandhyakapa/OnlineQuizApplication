<%@ page import="QuizApp.*" %>
<%@ page import="java.util.*" %>

<% 
Quiz quiz = new Quiz();
quiz.Subject = request.getParameter("Subject");
out.println(request.getParameter("start_date"));
 /*quiz.Total_Questions =(int) request.getParameter("Total_Questions");
 
 quiz.Start_date = request.getParameter("Start_date");
 quiz.end_date = request.getParameter("end_date");
 quiz.Duration =(int) request.getParameter("Duration");
 out.println(quiz);*/
 session.setAttribute("quiz",quiz);
 session.setAttribute("currentQuestion",1);
 response.sendRedirect("CreateQuizWithQuestions.jsp");



%>