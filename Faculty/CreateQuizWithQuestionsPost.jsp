<%@ page import="java.util.*" %>
<%@ page import="QuizApp.*" %>
<% 

Quiz quiz = (Quiz) session.getAttribute("quiz");
int currentQuestion = (int) session.getAttribute("currentQuestion");
Question q = new Question();
q.question = request.getParameter("Question");
q.Option_A = request.getParameter("Option_A");
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
    //first insert for quiz table

    
    for (int key : quiz.Questions.keySet()) {
    {
        Question questionObj = quiz.Questions.get(key);
        out.println("<br/>Question Number: " + key + ", :: \nQuestion :" + questionObj.question+"::\nOptionA :" + questionObj.Option_A);
    }
    

    //response.sendRedirect("QuizCreated.jsp");
}
}
 

%>
