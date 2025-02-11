<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <style>
        /* Global Styling */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        body {
            background: linear-gradient(135deg, #2c3e50, #3498db);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            animation: fadeIn 1s ease-in-out;
        }

        /* Container */
        .container {
            background: rgba(255, 255, 255, 0.1);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 0px 20px rgba(0, 255, 255, 0.5);
            width: 90%;
            max-width: 400px;
            text-align: center;
            animation: slideIn 1s ease-in-out;
        }

        /* Title */
        .container_title {
            font-size: 24px;
            font-weight: bold;
            color: white;
            margin-bottom: 20px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            animation: bounce 1.2s infinite alternate;
        }

        /* Input Box */
        .input_box {
            position: relative;
            margin-bottom: 15px;
            width: 100%;
        }

        .details {
            display: block;
            text-align: left;
            color: white;
            font-weight: bold;
            margin-bottom: 5px;
        }

        /* Input Fields */
        .input_box input {
            width: 100%;
            padding: 12px;
            border-radius: 5px;
            border: none;
            outline: none;
            font-size: 16px;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            transition: 0.3s ease-in-out;
        }

        /* Input Focus Effect */
        .input_box input:focus {
            background: rgba(255, 255, 255, 0.3);
            transform: scale(1.02);
        }

        /* Button */
        .button input[type="submit"] {
            width: 100%;
            padding: 12px;
            background: cyan;
            border: none;
            border-radius: 5px;
            font-size: 18px;
            font-weight: bold;
            color: black;
            cursor: pointer;
            transition: 0.3s ease-in-out;
        }

        .button input[type="submit"]:hover {
            background: white;
            color: black;
            transform: scale(1.05);
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes slideIn {
            from { opacity: 0; transform: translateX(-30px); }
            to { opacity: 1; transform: translateX(0); }
        }

        @keyframes bounce {
            from { transform: translateY(0); }
            to { transform: translateY(5px); }
        }

        /* Responsive Design */
        @media (max-width: 600px) {
            .container {
                width: 95%;
                padding: 20px;
            }
        }
    </style>
</head>
<body>

<%
    String result = "";
    if (request.getParameter("s1") != null) {
        String username = request.getParameter("a1");
        String password = request.getParameter("a2");

        if ("admin".equals(username) && "admin".equals(password)) {
            response.sendRedirect("server_home.jsp"); // Redirect to home page
        } else {
            result = "failure";
        }
    }
%>

<div class="container">
    <div class="container_title">Login</div>

    <form action="server.jsp" method="post">
        <div class="input_box">
            <span class="details">User Name</span>
            <input type="text" name="a1" required>
        </div>
        <div class="input_box">
            <span class="details">Password</span>
            <input type="password" name="a2" required>
        </div>

        <div class="input_box button">
            <input type="submit" name="s1" value="Login"> 
        </div>
    </form>
</div>

<% if ("failure".equals(result)) { %>
    <script>
        alert("Login Failed! Invalid Username or Password.");
    </script>
<% } %>

</body>
</html>
