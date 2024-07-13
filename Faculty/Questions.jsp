<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>-->

        <%
        out.println("Questions.jsp page");
            // Database connection details
            String url = "jdbc:mysql://localhost:3306/onlinequizapp";
            String user = "root";
            String password = "Sandhya@123";
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                 conn = DriverManager.getConnection(url, user, password);
                 stmt = conn.createStatement();
                 out.println("Try block");


                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    // Handle form submission
                    String Question = request.getParameter("Question");
                    String Option_A = request.getParameter("Option_B");
                    String Option_B = request.getParameter("Option_B");
                    String Option_C = request.getParameter("Option_C");
                    String Option_D = request.getParameter("Option_D");
                    String Correct_Answer = request.getParameter("Correct_Answer");

                    String insertSQL = "INSERT INTO question (Quiz_id, Question, Option_A, Option_B, Option_C, Option_D, Correct_Answer) VALUES (1, ?, ?, ?, ?, ?, ?)";
                    PreparedStatement pstmt = conn.prepareStatement(insertSQL);
                    pstmt.setString(1, Question);
                    pstmt.setString(2, Option_A);
                    pstmt.setString(3, Option_B);
                    pstmt.setString(4, Option_C);
                    pstmt.setString(5, Option_D);
                    pstmt.setString(6, Correct_Answer);
                    pstmt.executeUpdate();
                    out.println("Question"+Question);
                   
                    
                } 
            } catch (Exception e) {
                e.printStackTrace();
                out.println("Catch block");
            }
        %>
