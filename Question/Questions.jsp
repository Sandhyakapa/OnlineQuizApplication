<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

        <%
            // Database connection details
            String url = "jdbc:mysql://localhost:3306/onlinequizapp";
            String user = "root";
            String password = "Sandhya@123";
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, password);
                stmt = conn.createStatement();

                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    // Handle form submission
                    String question = request.getParameter("question");
                    String option_a = request.getParameter("option_a");
                    String option_b = request.getParameter("option_b");
                    String option_c = request.getParameter("option_c");
                    String option_d = request.getParameter("option_d");
                    String correct_answer = request.getParameter("correct_answer");

                    String insertSQL = "INSERT INTO questions (quiz_id, question, option_a, option_b, option_c, option_d, correct_answer) VALUES (1, ?, ?, ?, ?, ?, ?)";
                    PreparedStatement pstmt = conn.prepareStatement(insertSQL);
                    pstmt.setString(1, question);
                    pstmt.setString(2, option_a);
                    pstmt.setString(3, option_b);
                    pstmt.setString(4, option_c);
                    pstmt.setString(5, option_d);
                    pstmt.setString(6, correct_answer);
                    pstmt.executeUpdate();
                } else if (request.getParameter("delete_id") != null) {
                    // Handle delete request
                    String deleteId = request.getParameter("delete_id");
                    String deleteSQL = "DELETE FROM questions WHERE question_id = ?";
                    PreparedStatement pstmt = conn.prepareStatement(deleteSQL);
                    pstmt.setInt(1, Integer.parseInt(deleteId));
                    pstmt.executeUpdate();
                }

                // Fetch questions
                String selectSQL = "SELECT * FROM questions";
                rs = stmt.executeQuery(selectSQL);
                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getInt("question_id") + "</td>");
                    out.println("<td>" + rs.getString("question") + "</td>");
                    out.println("<td>" + rs.getString("option_a") + "</td>");
                    out.println("<td>" + rs.getString("option_b") + "</td>");
                    out.println("<td>" + rs.getString("option_c") + "</td>");
                    out.println("<td>" + rs.getString("option_d") + "</td>");
                    out.println("<td>" + rs.getString("correct_answer") + "</td>");
                    out.println("<td><a href='questions.jsp?delete_id=" + rs.getInt("question_id") + "'>Delete</a></td>");
                    out.println("</tr>");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
