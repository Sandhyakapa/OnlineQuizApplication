<%@ page import="java.sql.*, java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="java.util.*" %>


<%
    Integer facultyId = (Integer) session.getAttribute("facultyID");
    Integer quizId = Integer.parseInt(request.getParameter("quizId")); // Assuming quizId is passed as a request parameter

    if (facultyId != null && quizId != null) {
        String url = "jdbc:mysql://localhost:3306/onlinequizapp"; // Update with your database URL
        String user = "root";  // Update with your database username
        String password = "Sandhya@123"; // Update with your database password

        String query = "SELECT "
                       + "quiz.Quiz_id, quiz.Subject, quiz.Start_date, quiz.end_date, quiz.Duration, quiz.Total_Questions, "
                       + "student.StudentID, student.Name AS StudentName, attended_quizzes.marks "
                       + "FROM quiz "
                       + "JOIN attended_quizzes ON quiz.Quiz_id = attended_quizzes.Quiz_id "
                       + "JOIN student ON attended_quizzes.StudentID = student.StudentID "
                       + "JOIN faculty ON faculty.FacultyID = quiz.Created_By "
                       + "WHERE faculty.FacultyID = ? AND quiz.Quiz_id = ?";

        try (Connection con = DriverManager.getConnection(url, user, password);
             PreparedStatement pst = con.prepareStatement(query)) {

            pst.setInt(1, facultyId);
            pst.setInt(2, quizId);

            try (ResultSet rs = pst.executeQuery()) {
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Student Results</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="../css/bootstrap.min.css" rel="stylesheet">
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
    <div class="container">
        <h2>Student Results</h2>
        <table>
            <tr>
                <th>Quiz ID</th>
                <th>Subject</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Duration</th>
                <th>Total Questions</th>
                <th>Student ID</th>
                <th>Student Name</th>
                <th>Score</th>
            </tr>
            <% 
                while (rs.next()) { 
                    int quizIdResult = rs.getInt("Quiz_id");
                    String subject = rs.getString("Subject");
                    java.sql.Date startDate = rs.getDate("Start_date");
                    java.sql.Date endDate = rs.getDate("end_date");
                    int duration = rs.getInt("Duration");
                    int totalQuestions = rs.getInt("Total_Questions");
                    String studentId = rs.getString("StudentID");
                    String studentName = rs.getString("StudentName");
                    int score = rs.getInt("marks");
            %>
            <tr>
                <td><%= quizIdResult %></td>
                <td><%= subject %></td>
                <td><%= startDate %></td>
                <td><%= endDate %></td>
                <td><%= duration %></td>
                <td><%= totalQuestions %></td>
                <td><%= studentId %></td>
                <td><%= studentName %></td>
                <td><%= score %></td>
            </tr>
            <% 
                } 
            %>
        </table>
    </div>
</body>
</html>

            <% 
            } catch (SQLException e) {
                e.printStackTrace();
            }
            finally{
                
            }
         else { // This closes the "if" statement
    %>
        <p>Invalid faculty or quiz ID. Please check your inputs.</p>
    <%
        }
    %>
