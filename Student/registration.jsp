
<%@ page import="java.util.*" %>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirmPassword");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");

    boolean hasErrors = false;
    Map<String, String> errors = new HashMap<>();

    if (request.getMethod().equalsIgnoreCase("POST")) {
        if (username == null || username.trim().isEmpty()) {
            errors.put("username", "Username is required.");
            hasErrors = true;
        }

        if (password == null || password.trim().isEmpty()) {
            errors.put("password", "Password is required.");
            hasErrors = true;
        }

        if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
            errors.put("confirmPassword", "Confirm Password is required.");
            hasErrors = true;
        } else if (!password.equals(confirmPassword)) {
            errors.put("confirmPassword", "Passwords do not match.");
            hasErrors = true;
        }

        if (email == null || email.trim().isEmpty()) {
            errors.put("email", "Email is required.");
            hasErrors = true;
        }

        if (phone == null || phone.trim().isEmpty()) {
            errors.put("phone", "Phone number is required.");
            hasErrors = true;
        }

        if (!hasErrors) {
            // Process the registration (e.g., save to database)
            // For now, just redirect to a success page
            response.sendRedirect("registration-success.jsp");
        }
        else{
            response.sendRedirect("Error.html");
        }
    }
%>
