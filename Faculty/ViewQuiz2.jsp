<%@ page import="java.sql.*, java.util.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="QuizApp.*" %>

<%
    // Database connection details
    String jdbcUrl = "jdbc:mysql://localhost:3306/onlinequizapp";
    String jdbcUser = "root";
    String jdbcPassword = "Sandhya@123"; // Change this to your actual database password

    // Get quiz ID from request
    String quizIdParam = request.getParameter("quizId");
    if (quizIdParam == null) {
        response.sendRedirect("facultyDashboard.jsp");
        return;
    }
    int quizId = Integer.parseInt(quizIdParam);

    Quiz quiz = null;
    List<Question> questions = new ArrayList<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection conn = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword)) {
            // Fetch quiz details
            String quizQuery = "SELECT * FROM quiz WHERE Quiz_id = ?";
            try (PreparedStatement quizStmt = conn.prepareStatement(quizQuery)) {
                quizStmt.setInt(1, quizId);
                ResultSet quizRs = quizStmt.executeQuery();
                if (quizRs.next()) {
                    String subject = quizRs.getString("Subject");
                    String startDate = quizRs.getString("Start_date");
                    String endDate = quizRs.getString("end_date");
                    int duration = quizRs.getInt("Duration");
                    int totalQuestions = quizRs.getInt("Total_Questions");
                    int createdBy = quizRs.getInt("Created_By");

                    // Fetch faculty name
                    String facultyQuery = "SELECT Name FROM faculty WHERE FacultyID = ?";
                    try (PreparedStatement facultyStmt = conn.prepareStatement(facultyQuery)) {
                        facultyStmt.setInt(1, createdBy);
                        ResultSet facultyRs = facultyStmt.executeQuery();
                        String facultyName = "";
                        if (facultyRs.next()) {
                            facultyName = facultyRs.getString("Name");
                        }

                        quiz = new Quiz(quizId, subject, startDate, endDate, "", duration, totalQuestions, createdBy);
                        session.setAttribute("quiz", quiz);
                        session.setAttribute("facultyName", facultyName);
                    }

                    // Fetch quiz questions
                    String questionQuery = "SELECT * FROM question WHERE Quiz_id = ? ORDER BY Question_no";
                    try (PreparedStatement questionStmt = conn.prepareStatement(questionQuery)) {
                        questionStmt.setInt(1, quizId);
                        ResultSet questionRs = questionStmt.executeQuery();
                        while (questionRs.next()) {
                            String questionText = questionRs.getString("Question");
                            String optionA = questionRs.getString("Option_A");
                            String optionB = questionRs.getString("Option_B");
                            String optionC = questionRs.getString("Option_C");
                            String optionD = questionRs.getString("Option_D");
                            char correctAnswer = questionRs.getString("Correct_Answer").charAt(0);

                            Question question = new Question(questionText, optionA, optionB, optionC, optionD, correctAnswer);
                            questions.add(question);
                        }
                    }
                } else {
                    out.println("<p>No quiz found with ID: " + quizId + "</p>");
                }
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<p>Error accessing the database: " + e.getMessage() + "</p>");
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.println("<p>MySQL JDBC Driver not found: " + e.getMessage() + "</p>");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Quiz</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 15px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h2>View Quiz</h2>
    <p><strong>Quiz ID:</strong> <%= quizId %></p>
    <p><strong>Subject:</strong> <%= quiz.Subject %></p>
    <p><strong>Start Date:</strong> <%= quiz.Start_date %></p>
    <p><strong>End Date:</strong> <%= quiz.end_date %></p>
    <p><strong>Duration:</strong> <%= quiz.duration %> minutes</p>
    <p><strong>Total Questions:</strong> <%= quiz.Total_Questions %></p>
    <p><strong>Created By:</strong> <%= session.getAttribute("facultyName") %></p>

    <h3>Questions</h3>
    <table>
        <tr>
            <th>Question</th>
            <th>Option A</th>
            <th>Option B</th>
            <th>Option C</th>
            <th>Option D</th>
            <th>Correct Answer</th>
        </tr>
        <% for (Question question : questions) { %>
            <tr>
                <td><%= question.question %></td>
                <td><%= question.Option_A %></td>
                <td><%= question.Option_B %></td>
                <td><%= question.Option_C %></td>
                <td><%= question.Option_D %></td>
                <td><%= question.Correct_Answer %></td>
            </tr>
        <% } %>
    </table>
</body>
</html>
