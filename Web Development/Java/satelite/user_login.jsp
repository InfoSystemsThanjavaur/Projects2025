
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Login</title>

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <!-- CSS Styling -->
    <style>
        /* Reset Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        /* Body Styling */
        body {
            background-color: #f4e4ba; /* Light Lemon Chiffon */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        /* Container */
        .container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 100%;
            max-width: 400px;
            animation: fadeIn 0.8s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Title */
        .container_title {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            font-weight: bold;
        }
        .container_title i {
            font-size: 24px;
            color: #ff4500;
        }

        /* Input Fields */
        .input_box {
            margin-bottom: 15px;
            position: relative;
            width: 100%;
        }
        .input_box input {
            width: 100%;
            padding: 12px 40px;
            border: 1px solid #ddd;
            border-radius: 5px;
            outline: none;
            font-size: 16px;
            background: #fff;
            transition: all 0.3s ease-in-out;
        }
        .input_box input:focus {
            border-color: #ff4500;
            box-shadow: 0px 0px 5px rgba(255, 69, 0, 0.5);
        }
        .input_box i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: gray;
            font-size: 16px;
        }

        /* Login Button */
        .button input {
            width: 100%;
            padding: 12px;
            background-color: #ff4500;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s ease-in-out;
            font-size: 16px;
        }
        .button input:hover {
            background-color: #e03d00;
        }

        /* Mobile Responsive */
        @media (max-width: 600px) {
            .container {
                width: 90%;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="container_title">
            <i class="fas fa-user-lock"></i> User Login
        </div>
        <form action="user_login.jsp" method="post">
            <div class="input_box">
                <i class="fas fa-user"></i>
                <input type="text" name="username" placeholder="Username" required>
            </div>
            <div class="input_box">
                <i class="fas fa-lock"></i>
                <input type="password" name="password" placeholder="Password" required>
            </div>
            <div class="input_box button">
                <input type="submit" name="submit" value="Login">
            </div>
        </form>
    </div>

    <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            
            Connection conn = null;
            PreparedStatement pst = null;
            ResultSet rs = null;
            
            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/satelite", "root", "root");
                String sql = "SELECT * FROM users WHERE un=? AND password=?";
                pst = conn.prepareStatement(sql);
                pst.setString(1, username);
                pst.setString(2, password);
                rs = pst.executeQuery();
                
                if (rs.next()) {
                    response.sendRedirect("user_home.html");
                } else {
                    out.println("<script>alert('Login failed! Incorrect username or password.');</script>");
                }
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (conn != null) conn.close();
            }
        }
    %>
</body>
</html>
