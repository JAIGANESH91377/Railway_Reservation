<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ticket Booking Form</title>
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
        
        input[type="button"] {
            background-color: #6495ED;
            color: Black;
            font-weight: bold
            cursor: pointer;
        }

        input[type="button"]:hover {
            background-color: #6495ED;
        }

        .success-message {
            color: #4caf50;
            font-weight: bold;
        }
    </style>
</head>
<body>
<h2>Ticket Booking Form</h2>
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
        <input type="submit" value="Confirm Booking">
        <a href="CancelBooking.jsp"><input type="button" value="Cancel Booking"></a>
    </form>
    <script>
        function showConfirmation() {
            var confirmation = confirm("Do you want to confirm the booking?");
            return confirmation;
        }
    </script>

    <%
    if (request.getMethod().equalsIgnoreCase("post")) {
        String trainName = request.getParameter("trainName");
        String journeyFrom = request.getParameter("journeyFrom");
        String journeyTo = request.getParameter("journeyTo");
        String classType = request.getParameter("classType");
        String departureDate = request.getParameter("departureDate");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String gender = request.getParameter("gender");
        String phoneNumberStr = request.getParameter("phoneNumber");
        String email = request.getParameter("email");

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

            String query = "INSERT INTO BookTicket (Train_Name, Journey_From, Journey_To, Class, Departure_Date, First_Name, Last_Name, Gender, Phone_Number, Email) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setString(1, trainName);
                preparedStatement.setString(2, journeyFrom);
                preparedStatement.setString(3, journeyTo);
                preparedStatement.setString(4, classType);
                preparedStatement.setString(5, departureDate);
                preparedStatement.setString(6, firstName);
                preparedStatement.setString(7, lastName);
                preparedStatement.setString(8, gender);
                preparedStatement.setInt(9, phoneNumber);
                preparedStatement.setString(10, email);

                int rowsAffected = preparedStatement.executeUpdate();

                if (rowsAffected > 0) {
                    out.println("<p class='success-message'>Booking successful!</p>");
                } else {
                    out.println("<p class='error-message'>Booking failed.</p>");
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
