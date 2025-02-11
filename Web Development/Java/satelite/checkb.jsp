<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daily Sales</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #121212;
            color: #fff;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            flex-direction: column;
        }
        .container {
            background: #1e1e1e;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 15px rgba(255, 255, 255, 0.2);
            text-align: center;
            max-width: 900px;
            width: 100%;
            animation: fadeIn 1s ease-in-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        h1 {
            color: #00d9ff;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #222;
            color: white;
        }
        th, td {
            border: 2px solid #00d9ff;
            padding: 12px;
            text-align: center;
        }
        th {
            background-color: #00d9ff;
            color: black;
        }
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            background: #00d9ff;
            color: black;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
        }
        input[type="submit"]:hover {
            background: #008fb3;
        }
        .icon {
            font-size: 18px;
            margin-right: 8px;
        }
        @media (max-width: 600px) {
            .container {
                width: 90%;
            }
            table {
                font-size: 12px;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <h1><i class="fas fa-chart-line"></i> Daily Sales</h1>
    <form action="checkb.jsp" method="post">
        <input type="submit" name="c3" value="Search">
    </form>

    <table>
        <tr><th colspan="4">Sales Data</th></tr>
        <tr>
            <th><i class="fas fa-user"></i> Customer Name</th>
            <th><i class="fas fa-id-badge"></i> Customer ID</th>
            <th><i class="fas fa-satellite"></i> Purchased Satellite</th>
            <th><i class="fas fa-comment"></i> Feedback</th>
        </tr>

        <% 
        Connection conn = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/satelite", "root", "root");
            String sql = "SELECT * FROM behavior";
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
        %>
                <tr>
                    <td><%= rs.getString("customer_name") %></td>
                    <td><%= rs.getString("customer_id") %></td>
                    <td><%= rs.getString("purchased_satellite") %></td>
                    <td><%= rs.getString("feedback") %></td>
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
