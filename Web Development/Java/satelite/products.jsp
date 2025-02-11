<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PRODUCTS</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }
        body {
            background: linear-gradient(135deg, #0f172a, #1e293b);
            color: white;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
        }
        .container {
            background: rgba(255, 255, 255, 0.1);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 0px 20px rgba(0, 255, 255, 0.5);
            width: 90%;
            max-width: 400px;
            text-align: center;
            animation: fadeIn 1s ease-in-out;
        }
        .container_title {
            font-size: 24px;
            margin-bottom: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
        }
        .container_title i {
            color: cyan;
            font-size: 28px;
        }
        .input_box {
            position: relative;
            margin-bottom: 15px;
            width: 100%;
        }
        .input_box i {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: white;
            font-size: 16px;
        }
        .input_box input {
            width: 100%;
            padding: 12px 15px 12px 40px;
            border-radius: 5px;
            border: none;
            outline: none;
            font-size: 14px;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            transition: 0.3s;
        }
        .input_box input:focus {
            background: rgba(255, 255, 255, 0.3);
            transform: scale(1.02);
        }
        .input_box input[type="submit"] {
            background: cyan;
            color: black;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
            width: 100%;
            border-radius: 5px;
        }
        .input_box input[type="submit"]:hover {
            background: white;
            color: black;
            transform: scale(1.05);
        }
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: scale(0.9);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="container_title">
            <h1><i class="fas fa-satellite"></i> <b>PRODUCTS</b></h1>
        </div>
        <form action="products.jsp" method="post">
            <div class="input_box">
                <i class="fas fa-satellite-dish"></i>
                <input type="text" name="satellite_name" placeholder="Satellite Name" required>
            </div>
            <div class="input_box">
                <i class="fas fa-cogs"></i>
                <input type="text" name="satellite_model" placeholder="Satellite Model" required>
            </div>
            <div class="input_box">
                <i class="fas fa-bullseye"></i>
                <input type="text" name="purpose" placeholder="Purpose" required>
            </div>
            <div class="input_box">
                <i class="fas fa-eye"></i>
                <input type="text" name="sensor" placeholder="Sensor" required>
            </div>
            <div class="input_box">
                <i class="fas fa-tachometer-alt"></i>
                <input type="text" name="speed" placeholder="Speed" required>
            </div>
            <div class="input_box">
                <i class="fas fa-microchip"></i>
                <input type="text" name="processor" placeholder="Processor" required>
            </div>
            <div class="input_box">
                <input type="submit" name="submit" value="Submit">
            </div>
        </form>
    </div>
    <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String satelliteName = request.getParameter("satellite_name");
            String satelliteModel = request.getParameter("satellite_model");
            String purpose = request.getParameter("purpose");
            String sensor = request.getParameter("sensor");
            String speed = request.getParameter("speed");
            String processor = request.getParameter("processor");
            
            Connection conn = null;
            PreparedStatement pst = null;
            
            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/satelite", "root", "root");
                
                String sql = "INSERT INTO products (satellite_name, satellite_model, purpose, sensor, speed, processor) VALUES (?, ?, ?, ?, ?, ?)";
                
                pst = conn.prepareStatement(sql);
                pst.setString(1, satelliteName);
                pst.setString(2, satelliteModel);
                pst.setString(3, purpose);
                pst.setString(4, sensor);
                pst.setString(5, speed);
                pst.setString(6, processor);
                
                int rowsInserted = pst.executeUpdate();
                if (rowsInserted > 0) {
                    out.println("<script>alert('Product details submitted successfully!');</script>");
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
