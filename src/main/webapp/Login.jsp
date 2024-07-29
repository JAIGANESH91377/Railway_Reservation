<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>User Login</title>
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
        }

        #login-container {
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
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            box-sizing: border-box;
        }

        input[type="submit"],
        input[type="reset"] {
            background-color: #6495ED;
            color: Black;
            border: none;
            padding: 10px 16px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 3px;
        }

        a {
            color: #2196F3;
            font-weight: bold;
            text-decoration: none;
        }
    </style>

    <script>
        function validateForm() {
            var username = document.forms["loginForm"]["txtName"].value;
            var password = document.forms["loginForm"]["txtPwd"].value;

            if (username === "" || password === "") {
                alert("Please enter both username and password.");
                return false;
            }

            // You can add more complex validation logic here if needed

            return true;
        }
    </script>
</head>
<body style="background-image: url('https://img.freepik.com/premium-photo/train-tracks-leading-into-sunset-with-sunset-background_771703-21432.jpg?w=740');">

<div id="login-container">
    <h1>User Login</h1>

    <form name="loginForm" action="LoginServlet" method="post" onsubmit="return validateForm();">

        <table>
            <tr>
                <td>Enter Name:</td>
                <td><input type="text" name="txtName" required></td>
            </tr>
            <tr>
                <td>Enter Password:</td>
                <td><input type="password" name="txtPwd" required></td>
            </tr>
            <tr>
                <td><input type="submit" value="Login"></td>
                <td><input type="reset"></td>
            </tr>
        </table>

        <p>Don't have an account? <a href="Register.jsp">Register here</a></p>

    </form>
</div>

</body>
</html>
