<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DAILY SALES</title>
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
            flex-direction: column;
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
            max-width: 900px;
            width: 100%;
            animation: slideUp 0.8s ease-in-out;
        }

        @keyframes slideUp {
            from { transform: translateY(30px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        h1 {
            color: #333;
            font-size: 24px;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #ffffff;
            margin-top: 20px;
        }

        th, td {
            border: 2px solid #ddd;
            padding: 10px;
            text-align: center;
            transition: all 0.3s;
        }

        th {
            background-color: #007BFF;
            color: white;
        }

        td:hover {
            background-color: #f1f1f1;
        }

        .search-btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background: #007BFF;
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .search-btn:hover {
            background: #0056b3;
        }

        .icon {
            font-size: 18px;
        }

        @media (max-width: 600px) {
            .container {
                width: 90%;
            }
            table {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <h1><i class="fas fa-shopping-cart icon"></i> DAILY SALES</h1>
    <form action="dailysales.jsp" method="post">
        
    </form>

    <table>
        <tr><th colspan="6">PRODUCT DATA</th></tr>
        <tr>
            <th>Satellite Name</th>
            <th>Satellite Model</th>
            <th>Quantity</th>
            <th>Quality</th>
            <th>Price</th>
            <th>Product Description</th>
        </tr>

        <% 
        Connection conn = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/satelite", "root", "root");
            String sql = "SELECT * FROM satellites";
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
        %>
                <tr>
                    <td><i class="fas fa-satellite icon"></i> <%= rs.getString("satellite_name") %></td>
                    <td><%= rs.getString("satellite_model") %></td>
                    <td><%= rs.getInt("quantity") %></td>
                    <td><%= rs.getString("quality") %></td>
                    <td><%= rs.getDouble("price") %></td>
                    <td><%= rs.getString("product_description") %></td>
                </tr>
        <% 
            }
            rs.close();
            pst.close();
        } catch (Exception e) {
        %>
            <script>alert("Error: <%= e.getMessage() %>");</script>
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
