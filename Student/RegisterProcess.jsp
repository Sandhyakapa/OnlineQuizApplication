<%@ page import = "java.sql.*" %>
<% 
    String Email = request.getParameter("Email");
    String Name = request.getParameter("Name");
    String Mobile_No = request.getParameter("Mobile_No");
    String PassWord = request.getParameter("PassWord");
    String Address = request.getParameter("Address");
    String SubjectID = request.getParameter("Subject_ID");  // Get Subject_ID from the form
    boolean isExceptionRaised = false;
    int studentID = 0;  // To hold the generated student ID
    int res = 0;

    try{
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish connection to the database
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinequizapp","root","Sandhya@123");

        // Start a transaction
        conn.setAutoCommit(false);

        // Insert into the 'student' table
        String sql = "INSERT INTO student(Email, Name, Mobile_No, PassWord, Address) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        ps.setString(1, Email);
        ps.setString(2, Name);
        ps.setString(3, Mobile_No);
        ps.setString(4, PassWord);
        ps.setString(5, Address);
        res = ps.executeUpdate();

        // Get the generated StudentID
        ResultSet generatedKeys = ps.getGeneratedKeys();
        if (generatedKeys.next()) {
            studentID = generatedKeys.getInt(1);  // Get the auto-generated StudentID
        }

        if (res > 0 && studentID > 0) {
            // Insert into the 'student_subject' table with 'Pending' approval status
            String subjectSQL = "INSERT INTO student_subject (StudentID, Subject_ID, Approval_Status) VALUES (?, ?, 'Pending')";
            PreparedStatement psSubject = conn.prepareStatement(subjectSQL);
            psSubject.setInt(1, studentID);
            psSubject.setString(2, SubjectID);
            int subjectRes = psSubject.executeUpdate();

            if (subjectRes > 0) {
                // Commit transaction if both inserts are successful
                conn.commit();
            } else {
                // Rollback if subject insertion fails
                conn.rollback();
                res = 0;  // Reset res to indicate failure
            }
        } else {
            // Rollback if student insertion fails
            conn.rollback();
        }
    } catch(Exception e) {
        isExceptionRaised = true;
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">
    <link href="../img/favicon.ico" rel="icon">
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/style.css" rel="stylesheet">
</head>

<body>
    <div class="container-xxl bg-white p-0">
        <nav class="navbar navbar-expand-lg bg-white navbar-light sticky-top px-4 px-lg-5 py-lg-0">
            <a href="index.html" class="navbar-brand">
                <h1 class="m-0 text-primary"><i class="fa fa-book-reader me-3"></i>Online Quiz Application</h1>
            </a>
        </nav>
    </div>
    <br><br>

<%
if (res > 0) {
    // Registration successful
%>
    <div>
        <h4 style="text-align: center;">Your registration has been completed successfully.</h4>
    </div>
    <div style="text-align: center;">
        <a href="Login.html" class="btn" style="background-color: green; color: white;">Login</a>
    </div>
<%
} else if (isExceptionRaised) {
    // Exception occurred
%>
    <div>
        <h5 style="text-align: center;">Student with email id: <%= Email %> is already registered. Please use another email id.</h5>
    </div>
    <div style="text-align: center;">
        <a href="Register.jsp" class="btn" style="background-color: red; color: white;">Register again</a>
    </div>
<%
} else {
    // Registration failed
%>
    <div>
        <h4 style="text-align: center;">Registration failed. Please try again.</h4>
    </div>
    <div style="text-align: center;">
        <a href="Register.jsp" class="btn" style="background-color: red; color: white;">Register again</a>
    </div>
<%
}
%>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
