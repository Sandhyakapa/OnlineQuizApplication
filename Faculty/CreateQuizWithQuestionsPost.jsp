<%@ page import="java.util.*" %>
<%@ page import="QuizApp.*" %>
<%@ page import = "java.sql.*" %>
<html>
    <head>
        <link href="../css/style.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
    </head>
</html>
<% 

Quiz quiz = (Quiz) session.getAttribute("quiz");
// int currentQuestion = (int) session.getAttribute("currentQuestion");

Integer Total_Questions = (Integer) session.getAttribute("Total_Questions");

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
session.setAttribute("quiz", quiz);

if (currentQuestion < Total_Questions) {
    session.setAttribute("currentQuestion", ++currentQuestion);
    response.sendRedirect("CreateQuizWithQuestions.jsp");
} else {
    // Code for inserting the data into the database
    //out.println("Quiz Name: " + quiz.Subject + "::Quiz StartDate:" + quiz.Start_date);
   // out.println("Quiz Name: " + quiz.Subject + "::Quiz StartDate:" + quiz.Start_date + "  Duration: " + quiz.duration + "  Total_Questions:" + quiz.Total_Questions);
    // first insert for quiz table


    Integer facultyId = (Integer) session.getAttribute("facultyId");
    if (facultyId == null) {
        response.sendRedirect("LoginProcess.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement quizPs = null;
    PreparedStatement questionPs = null;
    ResultSet rs = null;
    int res = 0;
    try {
        // out.println("Email=" + Email);
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinequizapp", "root", "Sandhya@123");
        //String sql = "insert into quiz(Subject, Start_date, end_date, Duration, Total_Questions) values(?,?,?,?,?)";
        String sql = "insert into quiz(Subject, Start_date, end_date, Duration, Total_Questions, Created_By) values(?,?,?,?,?,?)";
        quizPs = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        quizPs.setString(1, quiz.Subject);
        quizPs.setString(2, quiz.Start_date);
        quizPs.setString(3, quiz.end_date);
        quizPs.setInt(4, quiz.duration);
        quizPs.setInt(5, quiz.Total_Questions);
        quizPs.setInt(6, facultyId);
        res = quizPs.executeUpdate();

        if (res > 0) {
            rs = quizPs.getGeneratedKeys();
            if (rs.next()) {
                int quizId = rs.getInt(1);
                int updateCount =0;

                for (int key : quiz.Questions.keySet()) {
                    Question questionObj = quiz.Questions.get(key);

                    String questionSql = "INSERT INTO question (Quiz_id, Question_no, Question, Option_A, Option_B, Option_C, Option_D, Correct_Answer) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                    questionPs = conn.prepareStatement(questionSql);
                    questionPs.setInt(1, quizId);
                    questionPs.setInt(2, key);
                    questionPs.setString(3, questionObj.question);
                    questionPs.setString(4, questionObj.Option_A);
                    questionPs.setString(5, questionObj.Option_B);
                    questionPs.setString(6, questionObj.Option_C);
                    questionPs.setString(7, questionObj.Option_D);
                    questionPs.setString(8, String.valueOf(questionObj.Correct_Answer));
                    updateCount += questionPs.executeUpdate();
                     

                   
                    }

                    if(updateCount == quiz.Questions.size()){
                        %>
                        <script>

                            Swal.fire({
                                title: 'Success!',
                                text: "Quiz Created Successfully.",
                                icon: 'success',
                                confirmButtonText: 'OK',
                               
                                customClass: {
                                    title: 'my-title',
                                    confirmButton: 'custom-confirm-button',
                                    
                                }
                            }).then((result) => {
                                
                                 window.location.href = 'ViewAllQuizzes.jsp';
                            });
                        </script>
                        <%
                    }
                    
                    else{
                        %>
                        <script>

                            Swal.fire({
                                title: 'Failed!',
                                text: "Quiz Creation Failed.",
                                icon: 'error',
                                confirmButtonText: 'OK',
                               
                                customClass: {
                                    title: 'my-title',
                                    confirmButton: 'custom-confirm-button',
                                    
                                }
                            }).then((result) => {
                                
                                 window.location.href = 'CreateQuizFrontend.jsp';
                            });
                        </script>
                        <%
                }
            }
        }
    }
    catch (Exception e) {
        out.println(e);
    } finally {
        // Close resources
        try {
            if (rs != null) rs.close();
            if (quizPs != null) quizPs.close();
            if (questionPs != null) questionPs.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            out.println(e);
        }
    }

    //response.sendRedirect("QuizCreated.jsp");
}
%>
