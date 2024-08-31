<%@ page import="java.sql.*, java.util.*, javax.servlet.*, javax.servlet.http.*, java.io.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="QuizApp.*" %>
<%@ page import="java.lang.reflect.Type" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.reflect.TypeToken" %>

<%
int StudentId = (Integer) session.getAttribute("StudentId");

StringBuilder sb = new StringBuilder();
BufferedReader reader = request.getReader();
String line;
while ((line = reader.readLine()) != null) {
    sb.append(line);
}
String jsonString = sb.toString();
JSONObject jsonObject = new JSONObject(jsonString);

Gson gson = new Gson();
Type mapType = new TypeToken<Map<String, Object>>(){}.getType();
Map<String, Object> dataMap = gson.fromJson(jsonString, mapType);

// Read the user given data from AJAX call
Map<String, String> map = (Map<String, String>) dataMap.get("SelectedAnswers");

Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinequizapp", "root", "Sandhya@123");

String sql = "select Question_ID from question where Quiz_id=?";
PreparedStatement quizStmt = con.prepareStatement(sql);

String numberStr = String.valueOf(dataMap.get("QuizID"));
if (numberStr.endsWith(".0")) {
    numberStr = numberStr.substring(0, numberStr.length() - 2);
}

int quiz_id = Integer.parseInt(numberStr);
quizStmt.setInt(1, quiz_id);

ResultSet rs = quizStmt.executeQuery();
List<Integer> listQuestionIds = new ArrayList<>();
while (rs.next()) {
    listQuestionIds.add(rs.getInt(1));
}

HashMap<Integer, Integer> mapStudentSelectedOptions = new HashMap<>();
for (int questionId : listQuestionIds) {
    String strSelectedOption = "rdbQuestion" + questionId;
    if (map.containsKey(strSelectedOption)) {
        int selectedOption = Integer.parseInt(map.get(strSelectedOption));
        mapStudentSelectedOptions.put(questionId, selectedOption);
    }
}

// Inserting User selected option into student_answers table
try {
    sql = "insert into student_answers(Quiz_id, Question_Id, StudentID, Selected_Option) values(?,?,?,?)";
    PreparedStatement ps = con.prepareStatement(sql);
    for (int questionId : mapStudentSelectedOptions.keySet()) {
        int selectedAnswer = mapStudentSelectedOptions.get(questionId);
        ps.setInt(1, quiz_id);
        ps.setInt(2, questionId);
        ps.setInt(3, StudentId);
        ps.setInt(4, selectedAnswer);

        int res = ps.executeUpdate();
        if (res <= 0) {
            out.println("Insertion Failed for Question ID: " + questionId);
        }
    }
    ps.close();
} catch (Exception e) {
    out.println("Error inserting student answers: " + e.getMessage());
    e.printStackTrace();
}

// Fetching marks
try {
    sql = "SELECT count(*) as student_marks FROM question INNER JOIN student_answers ON question.Quiz_id = student_answers.Quiz_id and question.Question_ID = student_answers.Question_ID where question.Quiz_id=? and question.Correct_Answer = student_answers.Selected_Option AND Student_Answers.StudentID = ?";
    quizStmt = con.prepareStatement(sql);
    quizStmt.setInt(1, quiz_id);
    quizStmt.setInt(2, StudentId);
    rs = quizStmt.executeQuery();
    int marks = 0;
    if (rs.next()) {
        marks = rs.getInt(1);
    }
    out.println("Your Marks: " + marks + "/" + listQuestionIds.size());

    // Update marks
    sql = "UPDATE attended_quizzes SET marks = ?, Attempted_TimeStamp = CURRENT_TIMESTAMP WHERE Quiz_id = ? AND StudentID = ?";
    PreparedStatement updateStmt = con.prepareStatement(sql);
    updateStmt.setInt(1, marks);
    updateStmt.setInt(2, quiz_id);
    updateStmt.setInt(3, StudentId);

    int updateRes = updateStmt.executeUpdate();
    if (updateRes > 0) {
        //out.println("Marks updated successfully...");
    } else {
        out.println("Marks update failed...");
    }
    updateStmt.close();
} catch (SQLException e) {
    out.println("SQL Error: " + e.getMessage());
    e.printStackTrace();
}  catch (Exception e) {
    out.println("Unexpected Error: " + e.getMessage());
    e.printStackTrace();
} finally {
    try {
        if (con != null && !con.isClosed()) {
            con.close();
        }
    } catch (SQLException e) {
        out.println("Error closing connection: " + e.getMessage());
        e.printStackTrace();
    }
}
%>
