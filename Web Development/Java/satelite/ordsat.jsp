<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ordered Satellite</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #141E30, #243B55);
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background: rgba(255, 255, 255, 0.1);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.3);
            text-align: center;
            max-width: 800px;
            width: 90%;
            color: white;
            backdrop-filter: blur(10px);
            animation: fadeIn 1s ease-in-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        h1 {
            font-size: 24px;
            margin-bottom: 15px;
            text-transform: uppercase;
        }
        .btn-container {
            margin-bottom: 15px;
        }
        input[type="submit"] {
            background: #00c6ff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
            box-shadow: 0 4px 8px rgba(0, 198, 255, 0.2);
        }
        input[type="submit"]:hover {
            background: #0072ff;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(5px);
            border-radius: 8px;
            overflow: hidden;
        }
        th, td {
            padding: 10px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.3);
            text-align: center;
            color: white;
        }
        th {
            background: rgba(0, 198, 255, 0.8);
        }
        tr:hover {
            background: rgba(0, 198, 255, 0.2);
        }
        .icon {
            margin-right: 8px;
        }
        @media (max-width: 600px) {
            .container {
                width: 95%;
            }
            table {
                font-size: 12px;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <h1><i class="fas fa-satellite-dish icon"></i> Ordered Satellites</h1>
    <form action="ordsat.jsp" method="post" class="btn-container">
        <input type="submit" name="c3" value="Search">
    </form>

    <table>
        <tr>
            <th>Satellite Name</th>
            <th>Satellite Model</th>
            <th>Quantity</th>
            <th>Address</th>
            <th>Phone No</th>
        </tr>

        <% 
        Connection conn = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/satelite", "root", "root");
            
            String sql = "SELECT * FROM purchased_satellites";
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
        %>
                <tr>
                    <td><%= rs.getString("satellite_name") %></td>
                    <td><%= rs.getString("satellite_model") %></td>
                    <td><%= rs.getInt("quantity") %></td>
                    <td><%= rs.getString("address") %></td>
                    <td><%= rs.getString("phone_number") %></td>
                </tr>
        <% 
            }
            rs.close();
            pst.close();
        } catch (Exception e) {
        %>
            <tr><td colspan="5">Error: <%= e.getMessage() %></td></tr>
        <%
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        %>

    </table>
</div>

</body>
</html>
