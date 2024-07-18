<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%
    // Retrieve the quiz ID and current question number from session
    Integer quizId = (Integer) session.getAttribute("quizId");
    Integer questionNo = (Integer) session.getAttribute("questionNo");

    if (quizId == null || questionNo == null) {
        // Redirect to an error page or display an error message
        response.sendRedirect("error.jsp");
        return;
    }

    // Get the modified question details from the request
    String question = request.getParameter("Question");
    String optionA = request.getParameter("Option_A");
    String optionB = request.getParameter("Option_B");
    String optionC = request.getParameter("Option_C");
    String optionD = request.getParameter("Option_D");
    String correctAnswerStr = request.getParameter("Correct_Answer");
    char correctAnswer = correctAnswerStr.charAt(0);

    Connection conn = null;
    PreparedStatement ps = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinequizapp", "root", "Sandhya@123");
        String sql = "UPDATE question SET Question = ?, Option_A = ?, Option_B = ?, Option_C = ?, Option_D = ?, Correct_Answer = ? WHERE Quiz_id = ? AND Question_no = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, question);
        ps.setString(2, optionA);
        ps.setString(3, optionB);
        ps.setString(4, optionC);
        ps.setString(5, optionD);
        ps.setString(6, String.valueOf(correctAnswer));
        ps.setInt(7, quizId);
        ps.setInt(8, questionNo);
        ps.executeUpdate();

        response.sendRedirect("ViewAllQuizzes.jsp");

    } catch (Exception e) {
        out.println(e);
    } finally {
        try {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            out.println(e);
        }
    }
%>
