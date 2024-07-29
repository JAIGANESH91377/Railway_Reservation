<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Railway Reservation System</title>

    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background: #f4f4f4;
            color: #333;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            background-image: url('https://images.fineartamerica.com/images/artworkimages/mediumlarge/1/a-canadian-pacific-train-travels-along-chris-bolin.jpg'); /* Set your background image URL here */
            background-size: cover;
        }

        #dashboard-container {
            background-color: transparent; /* Set background color to white with transparency */
            max-width: 1200px; /* Increase max-width to accommodate three columns */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
            text-align: center;
        }

        h1 {
            color: #fff; /* Set title text color to white */
            background-color: #333; /* Set title background color to dark gray */
            padding: 10px; /* Add padding to the title */
            border-radius: 5px; /* Add border-radius to the title */
        }

        .train-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
        }

        .train {
            border: 1px solid #ddd;
            margin: 20px 0;
            padding: 20px;
            border-radius: 10px;
            cursor: pointer;
            transition: background-color 0.3s;
            box-sizing: border-box;
            width: 30%; /* Set width to 30% for three columns */
        }

        .train:hover {
            background-color: #f9f9f9;
        }

        .train img {
            margin-top: 10px;
            max-width: 100%;
            height: auto;
            border-radius: 5px;
        }

        h2 {
            color: #000; /* Set Train ID text color to black */
        }

        p {
            font-weight: bold; /* Make Train details text bold */
        }

        button {
            background-color: #333; /* Set button background color to dark gray */
            color: white;
            border: none;
            padding: 10px;
            font-size: 16px;
            margin-top: 10px;
            cursor: pointer;
            border-radius: 5px;
        }
    </style>
</head>
<body>

<div id="dashboard-container">
    <h1>Railway Reservation System</h1>

    <div class="train-container">
        <% 
            try {
                // JDBC connection parameters
                String jdbcUrl = "jdbc:mysql://localhost:3306/railway_reservation";
                String dbUser = "root";
                String dbPassword = "Zx#Ud2aDay";

                // Load the JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish the database connection
                Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

                // Query to retrieve available trains
                String query = "SELECT * FROM AvailableTrains";
                Statement statement = connection.createStatement();
                ResultSet resultSet = statement.executeQuery(query);

                // Display the available trains
                while (resultSet.next()) {
                    int trainId = resultSet.getInt("Train_id");
                    String trainNo = resultSet.getString("Train_No");
                    String trainName = resultSet.getString("Train_Name");
                    String source = resultSet.getString("Source");
                    String destination = resultSet.getString("Destination");
                    Time time = resultSet.getTime("Time");
                    String imageURL = resultSet.getString("Image_URL");

        %>
        <div class="train" onclick="showTrainDetails(<%= trainId %>)">
            <h2>Train <%= trainId %></h2>
            <img src="<%= imageURL %>" alt="Train Image">
            <p>Train No: <%= trainNo %></p>
            <p>Train Name: <%= trainName %></p>
            <p>Source: <%= source %></p>
            <p>Destination: <%= destination %></p>
            <p>Time: <%= time %></p>
            <button onclick="BookTicket(<%= trainId %>)">Book Ticket</button>
        </div>
        <%
                }

                // Close resources
                resultSet.close();
                statement.close();
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </div>
    
<script>
function BookTicket(trainId) {
    // Redirect to the ticket booking page with the trainId as a parameter
    window.location.href = 'BookTicket.jsp?trainId=' + trainId;
}

</script>


</div>

</body>
</html>
