<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>REGISTER</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #74ebd5, #acb6e5);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            animation: fadeIn 1s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .container {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.2);
            text-align: center;
            max-width: 400px;
            width: 100%;
            animation: slideUp 0.8s ease-in-out;
        }

        @keyframes slideUp {
            from { transform: translateY(30px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        h1 {
            color: #333;
        }

        .input_box {
            margin-bottom: 15px;
            text-align: left;
        }

        .input_box span {
            font-weight: bold;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        input[type="date"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        input[type="submit"] {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            background: #007BFF;
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
        }

        input[type="submit"]:hover {
            background: #0056b3;
        }

        .one {
            margin-top: 10px;
            text-align: left;
        }

        @media (max-width: 600px) {
            .container {
                width: 90%;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1><i class="fas fa-user-plus"></i> REGISTER</h1>
        <form action="register.jsp" method="post">
            <div class="input_box">
                <span class="details"><i class="fas fa-user"></i> NAME</span>
                <input type="text" name="name" placeholder="Enter Name" required>
            </div>
            <div class="input_box">
                <span class="details"><i class="fas fa-phone"></i> MOBILE</span>
                <input type="text" name="mobile" placeholder="Mobile" required>
            </div>
            <div class="input_box">
                <span class="details"><i class="fas fa-envelope"></i> EMAIL</span>
                <input type="email" name="email" placeholder="Email" required>
            </div>
            <div class="input_box">
                <span class="details"><i class="fas fa-lock"></i> PASSWORD</span>
                <input type="password" name="password" placeholder="Password" required>
            </div>
            <div class="one">
                <i class="fas fa-venus-mars"></i> GENDER
                <input type="radio" name="gender" value="male"> Male
                <input type="radio" name="gender" value="female"> Female 
            </div>
            <div class="input_box">
                <span class="details"><i class="fas fa-calendar"></i> DATE</span>
                <input type="date" name="date" required>
            </div>
            <div class="input_box">
                <input type="submit" name="submit" value="Register">
            </div>
        </form>
    </div>

    <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String name = request.getParameter("name");
            String mobile = request.getParameter("mobile");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String gender = request.getParameter("gender");
            String date = request.getParameter("date");
            
            Connection conn = null;
            PreparedStatement pst = null;
            
            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/satelite", "root", "root");
                String sql = "INSERT INTO users (un, mobile, email, password, gender, date) VALUES (?, ?, ?, ?, ?, ?)";
                pst = conn.prepareStatement(sql);
                pst.setString(1, name);
                pst.setString(2, mobile);
                pst.setString(3, email);
                pst.setString(4, password);
                pst.setString(5, gender);
                pst.setString(6, date);
                
                int rowsInserted = pst.executeUpdate();
                if (rowsInserted > 0) {
                    out.println("<p>Registration successful!</p>");
                } else {
                    out.println("<p>Registration failed. Please try again.</p>");
                }
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                if (pst != null) pst.close();
                if (conn != null) conn.close();
            }
        }
    %>
</body>
</html>
