<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ticket Cancellation Form</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: url('https://images.fineartamerica.com/images/artworkimages/mediumlarge/2/sunset-train-daniel-pang.jpg') center center fixed;
            background-size: cover;
            margin: 20px;
            background-attachment: fixed;
        }

        h2 {
            color: #FFF;
            text-align: center; /* Center the title */
            font-weight: bold; 
        }

        form {
            max-width: 600px;
            margin: 0 auto;
            background-color: rgba(255, 255, 255, 0.8); /* Slightly transparent white overlay */
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin: 10px 0 5px;
            color: #333;
            font-weight: bold;
        }

        input, select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

		input[type="submit"] {
            background-color: #6495ED;
            color: Black;
            font-weight: bold
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #6495ED;
        }

        .success-message {
            color: #4caf50;
            font-weight: bold;
        }
    </style>
</head>
<body>
<h2>Ticket Cancellation Form</h2>
    <form action="#" method="post" onsubmit="return showConfirmation();">
            <label for="trainName">Train Name:</label>
        <input type="text" id="trainName" name="trainName" required><br>

        <label for="journeyFrom">Journey From:</label>
        <input type="text" id="journeyFrom" name="journeyFrom" required>

        <label for="journeyTo">Journey To:</label>
        <input type="text" id="journeyTo" name="journeyTo" required><br>

        <label for="classType">Class:</label>
        <select id="classType" name="classType">
            <option value="FirstClass">First Class</option>
            <option value="SecondClass">Second Class</option>
        </select><br>

        <label for="departureDate">Departure Date:</label>
        <input type="date" id="departureDate" name="departureDate" required><br>

        <label for="firstName">Passenger's First Name:</label>
        <input type="text" id="firstName" name="firstName" required>

        <label for="lastName">Last Name:</label>
        <input type="text" id="lastName" name="lastName" required><br>

        <label for="gender">Gender:</label>
        <select id="gender" name="gender">
            <option value="Male">Male</option>
            <option value="Female">Female</option>
            <option value="Others">Others</option>
        </select><br>

        <label for="phoneNumber">Phone Number:</label>
        <input type="tel" id="phoneNumber" name="phoneNumber" required><br>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required><br>

        <input type="submit" value="Cancel Booking">
    </form>
    <script>
        function showConfirmation() {
            var confirmation = confirm("Do you want to cancel the booking?");
            return confirmation;
        }
    </script>

    <%
        if (request.getMethod().equalsIgnoreCase("post")) {
            String trainName = request.getParameter("trainName");
            String departureDate = request.getParameter("departureDate");
            String phoneNumberStr = request.getParameter("phoneNumber");

            String JDBC_URL = "jdbc:mysql://localhost:3306/railway_reservation";
            String JDBC_USER = "root";
            String JDBC_PASSWORD = "Zx#Ud2aDay";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
                connection.setAutoCommit(true);

                // Handle NumberFormatException
                int phoneNumber = 0;
                try {
                    phoneNumber = Integer.parseInt(phoneNumberStr.trim());
                } catch (NumberFormatException e) {
                    out.println("<p class='error-message'>Error: Invalid phone number format.</p>");
                    return;
                }

                String query = "DELETE FROM BookTicket WHERE Train_Name = ? AND Departure_Date = ? AND Phone_Number = ?";
                try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                    preparedStatement.setString(1, trainName);
                    preparedStatement.setString(2, departureDate);
                    preparedStatement.setInt(3, phoneNumber);

                    int rowsAffected = preparedStatement.executeUpdate();

                    if (rowsAffected > 0) {
                        out.println("<p class='success-message'>Booking canceled successfully!</p>");
                    } else {
                        out.println("<p class='error-message'>No booking found for the provided details.</p>");
                    }
                } catch (SQLException e) {
                    out.println("<p class='error-message'>Error: " + e.getMessage() + "</p>");
                } finally {
                    if (connection != null) {
                        connection.close();
                    }
                }
            } catch (ClassNotFoundException | SQLException e) {
                out.println("<p class='error-message'>Error: " + e.getMessage() + "</p>");
            }
        }
    %>

</body>
</html>
