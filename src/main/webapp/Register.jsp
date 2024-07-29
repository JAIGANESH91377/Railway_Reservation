<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration</title>
    <style>
    body {
            font-family: 'Arial', sans-serif;
            background-size: cover;
            background-position: center;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background-image: url('https://img.freepik.com/premium-photo/train-tracks-leading-into-sunset-with-sunset-background_771703-21432.jpg?w=740'); /* Replace with your image path */
        }

        #register-container {
            background-color: rgba(255, 255, 255, 0.8);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
            width: 300px;
            text-align: center;
        }

        form {
            margin-top: 20px;
        }

        table {
            margin: 0 auto;
            width: 100%;
        }

        input[type="text"],
        input[type="password"],
        input[type="submit"],
        input[type="reset"],
        input[type="button"] {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            box-sizing: border-box;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        input[type="submit"],
        input[type="reset"],
        input[type="button"] {
            background-color: #6495ED;
            color: white;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover,
        input[type="reset"]:hover,
        input[type="button"]:hover {
            background-color: #45a049;
        }

        a {
            color: #2196F3;
            text-decoration: none;
            font-weight: bold;
        }
    </style>
</head>
<body>

<%
String username = request.getParameter("txtName");
String password = request.getParameter("txtPwd");

if (request.getMethod().equalsIgnoreCase("post") && username != null && password != null) {
    // Check if the username and password are not empty
    if (!username.isEmpty() && !password.isEmpty()) {
        try {
            // Load your MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connect to your MySQL database (replace "your_database_url", "your_database_user", and "your_database_password")
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway_reservation", "root", "Zx#Ud2aDay");

            // Check for duplicate data
            PreparedStatement checkDuplicate = connection.prepareStatement("SELECT * FROM users WHERE username = ?");
            checkDuplicate.setString(1, username);
            ResultSet resultSet = checkDuplicate.executeQuery();

            if (resultSet.next()) {
                // Display a warning message for duplicate data
                out.println("<script>alert('Username already exists. Please choose a different username.');</script>");
            } else {
                // Insert the new user into the 'users' table
                PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO users (username, password) VALUES (?, ?)");
                preparedStatement.setString(1, username);
                preparedStatement.setString(2, password);
                preparedStatement.executeUpdate();

                // Display a success message
                out.println("<script>alert('Registration successful!');</script>");
            }

            // Close the database connection
            resultSet.close();
            checkDuplicate.close();
            connection.close();

        } catch (ClassNotFoundException | SQLException e) {
            // Display an error message
            out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
            e.printStackTrace();
        }
    }
}
%>

<div id="register-container">
    <h1>User Registration</h1>

    <form method="post" action="<%= request.getRequestURI() %>">
        <input type="hidden" name="action" value="register">

        <table>
            <tr>
                <td><input type="text" name="txtName" placeholder="Enter Name" required></td>
            </tr>
            <tr>
                <td><input type="password" name="txtPwd" placeholder="Enter Password" required></td>
            </tr>
            <tr>
                <td><input type="submit" value="Register"></td>
            </tr>
            <tr>
                <td><input type="reset" value="Reset"></td>
            </tr>
         </table>
    </form>
    <p>Already have an account? <a href="Login.jsp">Login here</a></p>
</div>

</body>
</html>
