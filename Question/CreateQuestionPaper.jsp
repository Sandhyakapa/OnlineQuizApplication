<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quiz Submission</title>
</head>
<body>
    <%
        // Database connection setup
        String dbURL = "jdbc:mysql://localhost:3306/onlinequizapp";
        String dbUser = "root"; // replace with your DB username
        String dbPass = "Sandhya@123"; // replace with your DB password

        Connection conn = null;
        PreparedStatement ps = null;
        String message = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            // Retrieve quiz data from request
            String quizTitle = request.getParameter("quizTitle");

            for (int i = 1; i <= 10; i++) {
                String question = request.getParameter("Question" + i);
                String optionA = request.getParameter("Option_A" + i);
                String optionB = request.getParameter("Option_B" + i);
                String optionC = request.getParameter("Option_C" + i);
                String optionD = request.getParameter("Option_D" + i);
                int correctAnswer = Integer.parseInt(request.getParameter("Correct_Answer" + i));

                // Insert quiz data into the database
                String sql = "INSERT INTO question (Quiz_id, Question, Option_A, Option_B, Option_C, Option_D, Correct_Answer) VALUES (?, ?, ?, ?, ?, ?, ?)";
                ps = conn.prepareStatement(sql);
                ps.setString(1, quizTitle); // Assuming Quiz_id is a string, adjust if it's an int
                ps.setString(2, question);
                ps.setString(3, optionA);
                ps.setString(4, optionB);
                ps.setString(5, optionC);
                ps.setString(6, optionD);
                ps.setInt(7, correctAnswer);

                int result = ps.executeUpdate();
                if (result > 0) {
                    message = "Quiz submitted successfully!";
                } else {
                    message = "Failed to submit the quiz.";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "An error occurred while submitting the quiz: " + e.getMessage();
        } finally {
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>
    <h1><%= message %></h1>
</body>
</html>
