<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome</title>
    <script>
        function showPopupAndRedirect() {
            alert("Login successful!");
            window.location.replace("dashboard.jsp"); // Change to the actual URL of your dashboard page
        }

        // Wait for the page to load, then show the popup and redirect after a delay
        window.onload = function() {
            setTimeout(showPopupAndRedirect, 1000); // Adjust the delay time (in milliseconds) as needed
        };
    </script>
</head>
<body>

<!-- Your page content goes here -->

</body>
</html>
