<%@ page import="java.sql.*, java.util.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String jdbcUrl = "jdbc:mysql://localhost:3306/onlinequizapp";
    String jdbcUser = "root";
    String jdbcPassword = "Sandhya@123"; // Change this to your actual database password

    Integer facultyId = (Integer) session.getAttribute("facultyId");
    String facultyEmail = (String) session.getAttribute("facultyEmail");
    String facultyName = (String) session.getAttribute("facultyName");

    if (facultyId == null) {
        response.sendRedirect("LoginProcess.jsp");
        return;
    }

    List<Map<String, Object>> quizzes = new ArrayList<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection conn = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword)) {
            // Fetch quizzes for the faculty
            String quizQuery = "SELECT * FROM quiz WHERE Created_By = ?";
            try (PreparedStatement quizStmt = conn.prepareStatement(quizQuery)) {
                quizStmt.setInt(1, facultyId);
                ResultSet quizRs = quizStmt.executeQuery();
                while (quizRs.next()) {
                    Map<String, Object> quiz = new HashMap<>();
                    quiz.put("Quiz_id", quizRs.getInt("Quiz_id"));
                    quiz.put("Subject", quizRs.getString("Subject"));
                    quiz.put("Start_date", quizRs.getDate("Start_date"));
                    quiz.put("end_date", quizRs.getDate("end_date"));
                    quiz.put("Duration", quizRs.getInt("Duration"));
                    quiz.put("Total_Questions", quizRs.getInt("Total_Questions"));
                    quizzes.add(quiz);
                }

                if (quizzes.isEmpty()) {
                    out.println("<p>No quizzes found for faculty ID: " + facultyId + "</p>");
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

    // Handle delete action
    String action = request.getParameter("action");
    String quizId = request.getParameter("quizId");

    if ("delete".equals(action) && quizId != null) {
        try (Connection conn = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword)) {
            String deleteQuery = "DELETE FROM quiz WHERE Quiz_id = ?";
            try (PreparedStatement deleteStmt = conn.prepareStatement(deleteQuery)) {
                deleteStmt.setInt(1, Integer.parseInt(quizId));
                deleteStmt.executeUpdate();
                response.sendRedirect("facultyDashboard.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<p>Error deleting the quiz: " + e.getMessage() + "</p>");
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Quizzes</title>
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
        .operation-button {
            padding: 5px 10px;
            margin: 2px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        .operation-button.edit {
            background-color: #ff9800;
        }
        .operation-button.delete {
            background-color: #f44336;
        }
    </style>
</head>
<body>
    <h2>Faculty Dashboard</h2>
    <p>Welcome, Faculty Name: <%= facultyName %></p>
    <p>Email: <%= facultyEmail %></p>

    <h3>Your Quizzes</h3>
    <table>
        <tr>
            <th>Quiz ID</th>
            <th>Subject</th>
            <th>Start Date</th>
            <th>End Date</th>
            <th>Duration (minutes)</th>
            <th>Total Questions</th>
            <th>Actions</th>
        </tr>
        <% for (Map<String, Object> quiz : quizzes) { %>
            <tr>
                <td><%= quiz.get("Quiz_id") %></td>
                <td><%= quiz.get("Subject") %></td>
                <td><%= quiz.get("Start_date") %></td>
                <td><%= quiz.get("end_date") %></td>
                <td><%= quiz.get("Duration") %></td>
                <td><%= quiz.get("Total_Questions") %></td>
                <td>
                    <button class="operation-button view" onclick="viewQuiz(<%= quiz.get("Quiz_id") %>)">View</button>
                    <button class="operation-button edit" onclick="editQuiz(<%= quiz.get("Quiz_id") %>)">Edit</button>
                    <button class="operation-button delete" onclick="deleteQuiz(<%= quiz.get("Quiz_id") %>)">Delete</button>
                </td>
            </tr>
        <% } %>
    </table>

    <script>
        function viewQuiz(quizId) {
            window.location.href = 'viewQuiz.jsp?quizId=' + quizId;
        }

        function editQuiz(quizId) {
            window.location.href = 'editQuiz.jsp?quizId=' + quizId;
        }

        function deleteQuiz(quizId) {
            if (confirm('Are you sure you want to delete this quiz?')) {
                window.location.href = 'facultyDashboard.jsp?action=delete&quizId=' + quizId;
            }
        }
    </script>
</body>
</html>
