

<%@ page import="java.sql.*, java.util.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="QuizApp.*" %>

<%

// Get quiz ID from request
    String quizIdParam = request.getParameter("quizId");
    if (quizIdParam == null) {
        response.sendRedirect("ViewQuiz.jsp");
    }
    int quizId = Integer.parseInt(quizIdParam);

    int StudentId = (Integer) session.getAttribute("StudentId");
    int status = 1; //this is the quiz attended status, 1 = attended, 0= not attended

// Database connection details
    String jdbcUrl = "jdbc:mysql://localhost:3306/onlinequizapp";
    String jdbcUser = "root";
    String jdbcPassword = "Sandhya@123"; 

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);
            // Fetch quiz details
            String quizQuery = "insert into attended_quizzes (StudentID,Quiz_id, Status) values(?,?,?)";
            PreparedStatement quizStmt = conn.prepareStatement(quizQuery);
                quizStmt.setInt(1, StudentId);
                quizStmt.setInt(2, quizId);
                quizStmt.setInt(3,status);
                int updated_Records =  quizStmt.executeUpdate();
                if(updated_Records <= 0){
                    %>
        <script>
            // JavaScript to display an alert popup
            alert("This Quiz has been attempted already, Please check other quizzes.");
           document.location="ViewAllQuizzes.jsp";
        </script>
    <%
                }
               
            }
          catch (Exception e) {%>
            <script>
            alert("This Quiz has been attempted already, Please check other quizzes.");
            document.location="ViewAllQuizzes.jsp";
        </script>
            //e.printStackTrace();
           // out.println("<p>Error accessing the database: " + e.getMessage() + "</p>");
           <% }
%>


<!DOCTYPE html>

<html lang="en">

            <head>
                <style>

        button {
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            border: none;
            border-radius: 5px;
            background-color: #007bff;
            color: white;
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color: #0056b3;
        }
        dialog {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            padding: 20px;
            max-width: 400px;
            width: 100%;
            background-color: white;
            text-align: center;
        }
        dialog h2 {
            margin: 0 0 10px;
            font-size: 24px;
        }
        dialog p {
            font-size: 16px;
            margin: 0 0 20px;
            color: #555;
        }
        dialog button {
            margin: 0 5px;
        }
        dialog::backdrop {
            background-color: rgba(0, 0, 0, 0.5);
        }




                    body {
                        font-family: Arial, sans-serif;
                        display: flex;
                        flex-direction: column;
                        align-items: center;
                        margin: 0;
                        padding: 20px;
                        background-color: #f4f4f4;
                    }
                    .container {
                        width: 100%;
                        max-width: 800px;
                        background-color: #fff;
                        padding: 20px;
                        border-radius: 8px;
                        box-shadow: 0 4px 8px rgba(0,0,0,0.2);
                    }
                    h2 {
                        color: #333;
                        text-align: center;
                    }
                    .quiz-details {
                        margin-bottom: 20px;
                        text-align: center;
                    }
                    .quiz-details p {
                        font-size: 16px;
                        margin: 5px 0;
                    }
                    .questions-container {
                        margin: 20px 0;
                    }
                    .question {
                        margin-bottom: 30px;
                        padding: 10px;
                        background-color: #f9f9f9;
                        border: 1px solid #ddd;
                        border-radius: 5px;
                        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                    }
                    .question-number {
                        font-weight: bold;
                        font-size: 18px;
                        color: #db1212;
                    }
                    .question-text {
                        font-weight: bold;
                        font-size: 18px;
                     
                       
                        margin: 10px 0;
                        color: #040404;
                    }
                    .option {
                        font-size: 14px;
                        margin: 5px 0;
                        color: #666;
                    }
                    .correct-answer {
                        color: green;
                        font-weight: bold;
                    }
                    table {
                        font-family: 'Gill Sans', 'Gill Sans MT', 'Calibri', 'Trebuchet MS', 'sans-serif';
                        font-size: 20px;
                        text-align: center;
                        width: 100%;
                        border-collapse: collapse;
                        margin-top: 20px;
                        color: rgb(9, 9, 33);
                    }


                    .custom-radio {
            position: relative;
            display: inline-block;
            padding-left: 30px;
            margin-right: 20px;
            cursor: pointer;
            font-size: 18px;
            user-select: none;
        }

        .custom-radio input {
            position: absolute;
            opacity: 0;
            cursor: pointer;
        }

        .custom-radio .checkmark {
            position: absolute;
            top: 0;
            left: 0;
            height: 20px;
            width: 20px;
            background-color: #ccc;
            border-radius: 50%;
        }

        .custom-radio:hover input ~ .checkmark {
            background-color: #b3b3b3;
        }

        .custom-radio input:checked ~ .checkmark {
            background-color: #963252;
        }

        .custom-radio .checkmark:after {
            content: "";
            position: absolute;
            display: none;
        }

        .custom-radio input:checked ~ .checkmark:after {
            display: block;
        }

        .custom-radio .checkmark:after {
            top: 5px;
            left: 5px;
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background: white;
        }

        .beautiful-button {
    background-color: #4CAF50; /* Green background */
    border: none; /* Remove borders */
    color: white; /* White text */
    padding: 15px 32px; /* Add some padding */
    text-align: center; /* Center the text */
    text-decoration: none; /* Remove underline */
    display: inline-block; /* Get it to line up properly */
    font-size: 16px; /* Increase font size */
    margin: 4px 2px; /* Add some margin */
    cursor: pointer; /* Add a pointer cursor on hover */
    border-radius: 8px; /* Rounded corners */
    transition-duration: 0.4s; /* Transition effect */
}

 /* Styles to visually and functionally disable the div */
 .disabled {
            pointer-events: none; /* Disable all pointer events */
            opacity: 0.5; /* Make the div appear disabled */
        }

        .disabled * {
            pointer-events: none;
        }     

        .flashing {
            animation: flash 3s;
        }

        

        @keyframes flash {
            0% { opacity: 1; }
            50% { opacity: 0; }
            100% { opacity: 1; }
        }

      
                </style>
                <meta charset="utf-8">
                <title>Online Quiz Application </title>
                <meta content="width=device-width, initial-scale=1.0" name="viewport">
                <meta content="" name="keywords">
                <meta content="" name="description">

                <!-- Favicon -->
                <link href="../img/favicon.ico" rel="icon">

                <!-- Google Web Fonts -->
                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link
                    href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Inter:wght@600&family=Lobster+Two:wght@700&display=swap"
                    rel="stylesheet">

                <!-- Icon Font Stylesheet -->
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
                    rel="stylesheet">
                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                    rel="stylesheet">

                <!-- Libraries Stylesheet -->
                <link href="../lib/animate/animate.min.css" rel="stylesheet">
                <link href="../lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

                <!-- Customized Bootstrap Stylesheet -->
                <link href="../css/bootstrap.min.css" rel="stylesheet">

                <!-- Template Stylesheet -->
                <link href="../css/style.css" rel="stylesheet">

                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../lib/wow/wow.min.js"></script>
    <script src="../lib/easing/easing.min.js"></script>
    <script src="../lib/waypoints/waypoints.min.js"></script>
    <script src="../lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="../js/main.js"></script>
            </head>

            <body>
                <div class="container-xxl bg-white p-0">
                    <!-- Spinner Start -->
                    
                    <!-- Spinner End -->


                    <!-- Navbar Start -->
                    <nav class="navbar navbar-expand-lg bg-white navbar-light sticky-top px-4 px-lg-5 py-lg-0">
                        <a href="index.html" class="navbar-brand">
                            <h1 class="m-0 text-primary"><i class="fa fa-book-reader me-3"></i>Online Quiz App</h1>
                        </a>
                        <button type="button" class="navbar-toggler" data-bs-toggle="collapse"
                            data-bs-target="#navbarCollapse">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarCollapse">
                            <div class="navbar-nav mx-auto">
                                <a href="StudentHome.jsp" class="nav-item nav-link active">Dashboard</a>


                                <div class="nav-item dropdown">
                                    <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Quizzes</a>
                                    <div class="dropdown-menu rounded-0 rounded-bottom border-0 shadow-sm m-0">
                                        <a href="ViewAllQuizzes.jsp" class="dropdown-item">View/Attempt Quizzes</a>
                                    </div>
                                </div>
                                <a href="about.html" class="nav-item nav-link">View Result</a>

                                <div class="nav-item dropdown">
                                    <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Profile</a>
                                    <div class="dropdown-menu rounded-0 rounded-bottom border-0 shadow-sm m-0">
                                        <a href="facility.html" class="dropdown-item">View Profile</a>
                                        <a href="team.html" class="dropdown-item">Edit Profile</a>
                                        <a href="call-to-action.html" class="dropdown-item">Update Profile</a>
                                    </div>
                                </div>

                                <a href="Logout.jsp" class="nav-item nav-link">Logout</a>
                            </div>

                        </div>
                    </nav>

   
        <!-- Navbar End -->


    <!-- START -- Copy Your Form HTML code here-->
    <%
    

    

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
                    String questionQuery = "SELECT * FROM question where Quiz_id = ? ORDER BY Question_no";
                    try (PreparedStatement questionStmt = conn.prepareStatement(questionQuery)) {
                        questionStmt.setInt(1, quizId);
                        ResultSet questionRs = questionStmt.executeQuery();
                        while (questionRs.next()) {
                            int Question_id  = questionRs.getInt("Question_ID");
                            String questionText = questionRs.getString("Question");
                            String optionA = questionRs.getString("Option_A");
                            String optionB = questionRs.getString("Option_B");
                            String optionC = questionRs.getString("Option_C");
                            String optionD = questionRs.getString("Option_D");
                            char correctAnswer = questionRs.getString("Correct_Answer").charAt(0);

                            Question question = new Question(Question_id, questionText, optionA, optionB, optionC, optionD, correctAnswer);
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


 
    <div style="text-align: right;padding-right: 30px;font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;font-weight: bold;color: brown;">Welcome, <%= session.getAttribute("StudentName") %></div>
    <div style="text-align: right;padding-right: 30px;font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;font-weight: bold;color: brown;"><%= session.getAttribute("StudentName") %></div>
    
    
   
    <div class="container" style="width: 70%;background-color: rgb(197, 229, 238);" id="quizSession">
        <div 
        style="background-color: white;font-weight: bold; text-align: center; font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;font-size: 28px;color: rgb(11, 9, 24);">
        Quiz Session</div>
        
        <div class="container flashing"  style="width: 40%;background-color: #bc4242;display: none;" id="divMarks" >
            <div id="divMarksInternal" style="color: white;font-size: 20px;text-align: center;">
               Your Marks: 0/0
            </div>
            </div>
        <!-- design for showing Quiz session  -->
         <div id="QuizSession">
         <table>
            <tr>
                <td style="text-align: left;">Quiz ID : <%=quiz.Quiz_id%></td>
                <td style="text-align: right;">Total Questions : <%=quiz.Total_Questions%></td>
                
            </tr>
            <tr>
                <td style="text-align: left;">Subject : <%=quiz.Subject%></td>
                <td style="text-align: right;">Attempted Questions : <span id="attemptedQuestions" >0 </span></td>
                
            </tr>
            <tr>
                <td style="text-align: left;">Total Marks : <%=quiz.Total_Questions%></td>
                <td style="text-align: right;">Duration : <%=quiz.duration%> Minutes </td>
                
            </tr>
            <tr>
                <td style="text-align: left;"></td>
                <td style="text-align: right;">Remaining Time : <span class="timer" id="timer" style="color: red;" >0:0 Minutes</span></td>
               
            </tr>
         </table>
        </div>
        
</div>


<br>

<div class="container" style="width: 70%;background-color: rgb(234, 237, 238);">
    <div 
    style="background-color: white;font-weight: bold; text-align: center; font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;font-size: 26px;color: rgb(36, 38, 39);">
    Questions </div>
    <div class="questions-container"  id="divQuestions">
        <form name ="AttendQuizForm" id="AttendQuizForm" onsubmit="return disableDiv('divQuestions')" action="SubmitQuiz.jsp">
            <input type ="hidden" value = "<%=quiz.Quiz_id%>" name = "quiz_id">
       
        <% for (int i = 0; i < questions.size(); i++) {
            Question question = questions.get(i); 
            int answerCode = question.Correct_Answer + 16;
            char answer = (char) answerCode;
             
            %>
            <div  class="question">
                <p class="question-number">Question:</p>
                <p class="question-text" name=""><%= question.question %></p>
               
                <label class="custom-radio"><%= question.Option_A %>
                    <input type="radio" name="rdbQuestion<%=question.Question_Id  %>"  value ="1" >
                    <span class="checkmark"></span>
                </label><br>
                <label class="custom-radio"><%= question.Option_B %>
                    <input type="radio" name="rdbQuestion<%=question.Question_Id  %>"  value ="2" >
                    <span class="checkmark"></span>
                </label><br>
                <label class="custom-radio"><%= question.Option_C %>
                    <input type="radio" name="rdbQuestion<%=question.Question_Id  %>" value ="3">
                    <span class="checkmark"></span>
                </label><br>
                <label class="custom-radio"><%= question.Option_D %>
                    <input type="radio" name="rdbQuestion<%=question.Question_Id  %>"  value ="4" >
                    <span class="checkmark"></span>
                </label>

                

                <!-- <input type="radio" name="q1" value="A"><span class="option">&nbsp;&nbsp;A: <%= question.Option_A %> </span><br>
                <input type="radio" name="q1" value="A"><span class="option">&nbsp;&nbsp;<strong>B:</strong> <%= question.Option_B %></span><br>
                <input type="radio" name="q1" value="A"><span class="option">&nbsp;&nbsp;<strong>C:</strong> <%= question.Option_C %></span><br>
                <input type="radio" name="q1" value="A"><span class="option">&nbsp;&nbsp;<strong>D:</strong> <%= question.Option_D %></span><br> -->
                <!-- <p class="correct-answer" style="font-size: 16px;">Correct Answer: <%
                    
                  
                    out.println(Character.toString(answer)); 
                   
                    %>
                </p>-->
            </div>
        <% } %>


        <input type = "button" value = "Submit Quiz" class="beautiful-button" id="btnSubmitQuiz">
        <input type = "button" value = "Cancel Quiz" class="beautiful-button" style="background-color: red;"
         id="btnCancelQuiz" onclick="submitQuizFromCancel()">
        <!-- <input type="button" value="disable form" onclick="disableDiv('divQuestions')"> -->
       </form>
    </div>
</div>
       
    
       
  
    <dialog id="myDialog">
        <h2 style="font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;font-size: 25px;">
            Your Quiz time is up!</h2>
        <img src="..\img\timeisup.jpg" width="270px" height="250px"> <br><br>
        <p style="font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;font-size: large;">
            Thank you for attending this quiz, <br>Now you can proceed to view your marks.</p>
            <br>

            We are calculating your marks, please wait ...
        <!-- <button  id="btnCheckMarks">View Marks</button> -->
    </dialog>
<!--END -- Copy Your Form HTML code here-->


        <!-- Footer Start -->
        
        <!-- Footer End -->


        <!-- Back to Top -->
      
   <!-- //delete code start -->
   

   <!-- //delete code end -->


        

    <!-- JavaScript Libraries -->
     <script>
// Get the dialog and buttons

        
        // const closeDialogBtn = document.getElementById('btnCheckMarks');

        

        // // Close the dialog when the "Close" button is clicked
        // closeDialogBtn.addEventListener('click', () => {
        //     //navigate to view marks page.
        //     window.location.href = 'SubmitQuiz.jsp';
        // });
        const mapStudentAnswers = new Map();
        var globalTimer; 
        var isTimerElapsed = false;
        
    

        document.addEventListener('DOMContentLoaded', (event) => {
    let attemptedCount = 0;
    const attemptedCountElement = document.getElementById('attemptedQuestions');
    const radioButtons = document.querySelectorAll('input[type="radio"]');

    radioButtons.forEach((radioButton) => {
        radioButton.addEventListener('change', (event) => {
            const questionName = event.target.name;
            const selectedValue = $('input[name='+questionName+']:checked').val();
            mapStudentAnswers.set(questionName, selectedValue);
           
            attemptedCountElement.textContent = mapStudentAnswers.size;
            //const selectedRadioButton = document.querySelector(`input[name="${questionName}"]:checked`);
          //const selectedRadioButtons =   document.getElementsByName(questionName);

        //    console.log(selectedRadioButton);
            // if (selectedRadioButton) {
            //     // Check if this question has been attempted before
            //     if (!selectedRadioButton.dataset.attempted) {
            //         // Mark this question as attempted
            //         selectedRadioButton.dataset.attempted = "true";
            //         // Increment the attempted count
            //         attemptedCount++;
            //         // Update the displayed count
            //         attemptedCountElement.textContent = attemptedCount;
            //     }
            // }
        });
    });
});
        window.onload = function () {
            var duration = 3;//<%= quiz.duration  %> * 60 ; // Convert duration from minutes to seconds
            var display = document.querySelector('#timer');
            startTimer(duration, display);
        };
        //timer code
        function startTimer(duration, display) {
            var timer = duration, minutes, seconds;
            globalTimer = setInterval(function () {
                minutes = parseInt(timer / 60, 10);
                seconds = parseInt(timer % 60, 10);

                minutes = minutes < 10 ? "0" + minutes : minutes;
                seconds = seconds < 10 ? "0" + seconds : seconds;

                display.textContent = minutes + ":" + seconds+" Minutes";

                if (--timer < 0) {
                    isTimerElapsed = true;
                    timer = 0;
                    // You can add a function here to handle what happens when the timer ends.
                    clearInterval(globalTimer); // Stop the timer when it reaches 0
                    //disable questions form
                   
                    const dialog = document.getElementById('myDialog');
                    loadMarks();
                    dialog.showModal();
                   // window.location.href = 'ViewAllQuizzes.jsp';
                }
            }, 1000);
        }
        // document.getElementById("btnCheckMarks").addEventListener("click", function(event) {
        //     event.preventDefault(); // Prevent default anchor behavior
        //     document.getElementById("AttendQuizForm").submit(); // Trigger form submission
        // });

        function disableDiv(divName) {

            var div = document.getElementById(divName);
            div.classList.add('disabled');
            var elements = div.querySelectorAll('input, button, select, textarea,label');
            elements.forEach(function(element) {
                element.disabled = true;
            });
            return true;
        }
       
        $('#btnSubmitQuiz').click(function() {

            if(isTimerElapsed || confirm('Are you sure you want to Submit this Quiz?'))
          {
            clearInterval(globalTimer); 
            const mapObject = Object.fromEntries(mapStudentAnswers);
            var quizid = <%=quizId%>;

            const combinedObject = {
                SelectedAnswers :mapObject,
                QuizID: quizid
            };

            $.ajax({
                url: 'SubmitQuiz.jsp', // URL of the resource to fetch
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                data:  JSON.stringify(combinedObject),
                success: function(marks) {
                    disableDiv('divQuestions')
                    $('#divMarks').toggle();
                    $('#divMarksInternal').text(marks);
                    scrollToDiv('quizSession');                   
                   
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.error('AJAX error:', textStatus, errorThrown);
                }
            });
          }

            
        });


        function scrollToDiv(divElement) {
            document.getElementById(divElement).scrollIntoView({ behavior: 'smooth', block: 'start' });
        }

        function loadMarks()
        {
            var intervalMarksPage =setInterval(function () {
                
                    clearInterval(intervalMarksPage); // Stop the timer when it reaches 0
                    const dialog = document.getElementById('myDialog');
                    dialog.close();
                    $('#btnSubmitQuiz').click();
                    
                }
            , 2000);
        }

        function submitQuizFromCancel()
        {
            if(confirm('Are you sure you want to exit from this Quiz?'))
            {
                $('#btnSubmitQuiz').click();
            }
        }
     </script>
    <!-- <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script> -->
    
</body>

</html>