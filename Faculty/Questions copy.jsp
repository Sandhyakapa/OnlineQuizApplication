<%@ page import="java.sql.*,java.util.*,java.io.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

        <%
            // Database connection details
            String dbURL = "jdbc:mysql://localhost:3306/onlinequizapp";
            String dbUser = "root";
            String dbPassword = "Sandhya@123";

            Connection conn = null;
            PreparedStatement stmt = null;

            try {
                // Load the JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish a connection
                conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                // Retrieve form data
                //String quizTitle = request.getParameter("quizTitle");

                // Assuming there are 10 questions
                int numberOfQuestions = 10;
                List<String> questions = new ArrayList<>();
                List<String> optionsA = new ArrayList<>();
                List<String> optionsB = new ArrayList<>();
                List<String> optionsC = new ArrayList<>();
                List<String> optionsD = new ArrayList<>();
                List<String> correctAnswers = new ArrayList<>();

                for (int i = 1; i <= numberOfQuestions; i++) {
                    questions.add(request.getParameter("Question" + i));
                    optionsA.add(request.getParameter("Option_A" + i));
                    optionsB.add(request.getParameter("Option_B" + i));
                    optionsC.add(request.getParameter("Option_C" + i));
                    optionsD.add(request.getParameter("Option_D" + i));
                    correctAnswers.add(request.getParameter("Correct_Answer" + i));
                }

                // SQL query to insert quiz data into the database
                String sql = "INSERT INTO quiz (quiz_title, question, option_a, option_b, option_c, option_d, correct_answer) VALUES (?, ?, ?, ?, ?, ?, ?)";

                stmt = conn.prepareStatement(sql);

                for (int i = 0; i < numberOfQuestions; i++) {
                    //stmt.setString(1, quizTitle);
                    stmt.setString(2, questions.get(i));
                    stmt.setString(3, optionsA.get(i));
                    stmt.setString(4, optionsB.get(i));
                    stmt.setString(5, optionsC.get(i));
                    stmt.setString(6, optionsD.get(i));
                    stmt.setString(7, correctAnswers.get(i));
                    stmt.addBatch(); // Add to batch
                }

                int[] results = stmt.executeBatch(); // Execute batch

                // Displaying results
                //out.println("<div class='result'><strong>Quiz Title:</strong> " + quizTitle + "</div>");
                for (int i = 0; i < numberOfQuestions; i++) {
                    out.println("<div class='result'><strong>Question " + (i + 1) + ":</strong> " + questions.get(i) + "</div>");
                    out.println("<div class='result'><strong>a:</strong> " + optionsA.get(i) + "</div>");
                    out.println("<div class='result'><strong>b:</strong> " + optionsB.get(i) + "</div>");
                    out.println("<div class='result'><strong>c:</strong> " + optionsC.get(i) + "</div>");
                    out.println("<div class='result'><strong>d:</strong> " + optionsD.get(i) + "</div>");
                    out.println("<div class='result'><strong>Correct Answer:</strong> " + correctAnswers.get(i) + "</div>");
                    out.println("<hr>");
                }

                out.println("<div class='result'><strong>All data inserted successfully!</strong></div>");

            } catch (Exception e) {
                e.printStackTrace();
                out.println("<div class='result'><strong>Error:</strong> " + e.getMessage() + "</div>");
            } finally {
                if (stmt != null) {
                    try {
                        stmt.close();
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
       
