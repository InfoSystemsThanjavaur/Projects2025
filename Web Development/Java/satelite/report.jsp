<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>REPORT</title>
    <!-- Font Awesome for Icons -->
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</head>
<body>
    <div class="container">
        <div class="container_title">
            <i class="fas fa-satellite"></i>
            <h1><b>REPORT</b></h1>
        </div>
        <form action="report.jsp" method="post">
            <div class="input_box">
                <input type="text" name="satellite_name" placeholder="Satellite Name" required>
            </div>
            <div class="input_box">
                <input type="text" name="satellite_model" placeholder="Satellite Model" required>
            </div>
            <div class="input_box">
                <textarea name="condition" placeholder="Condition" required></textarea>
            </div>
            <div class="button_box">
                <input type="submit" name="submit" value="Submit">
            </div>
        </form>
    </div>

    <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String satelliteName = request.getParameter("satellite_name");
            String satelliteModel = request.getParameter("satellite_model");
            String condition = request.getParameter("condition");
            
            Connection conn = null;
            PreparedStatement pst = null;
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/satelite", "root", "root");
                String sql = "INSERT INTO reports (satellite_name, satellite_model, `condition`) VALUES (?, ?, ?)";
                pst = conn.prepareStatement(sql);
                pst.setString(1, satelliteName);
                pst.setString(2, satelliteModel);
                pst.setString(3, condition);
                
                int rowsInserted = pst.executeUpdate();
                if (rowsInserted > 0) {
                    out.println("<script>alert('Report submitted successfully!');</script>");
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
<style>
body {
    background: #0f172a;
    font-family: Arial, sans-serif;
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
    width: 350px;
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
    color: white;
}

.input_box {
    width: 100%;
    margin-bottom: 15px;
}

.input_box input, .input_box textarea {
    width: 100%;
    padding: 12px;
    border-radius: 8px;
    border: none;
    outline: none;
    font-size: 14px;
    background: rgba(255, 255, 255, 0.2);
    color: white;
    transition: 0.3s;
}

.input_box textarea {
    height: 80px;
    resize: none;
}

.input_box input:focus, .input_box textarea:focus {
    background: rgba(255, 255, 255, 0.3);
    transform: scale(1.02);
}

.button_box input[type="submit"] {
    background: cyan;
    color: black;
    font-weight: bold;
    cursor: pointer;
    transition: 0.3s;
    width: 100%;
    padding: 12px;
    border-radius: 8px;
    border: none;
}

.button_box input[type="submit"]:hover {
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

@media (max-width: 600px) {
    .container {
        width: 90%;
        padding: 20px;
    }
}
</style>
</html>
