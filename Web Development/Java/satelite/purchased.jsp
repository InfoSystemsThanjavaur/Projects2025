<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Purchased Satellite</title>

    <!-- Bootstrap & Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <style>
        /* Global Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        /* Page Background */
        body {
            background: linear-gradient(to right, #0f2027, #203a43, #2c5364);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        /* Container Styling */
        .container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 600px;
            animation: fadeIn 0.8s ease-in-out;
        }

        /* Heading */
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        /* Input Box Styling */
        .input-group {
            margin-bottom: 15px;
        }

        .input-group input {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            width: 100%;
            padding-left: 35px;
        }

        .input-group i {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: #555;
        }

        /* Submit Button */
        .btn-submit {
            background: #007bff;
            color: white;
            padding: 10px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            width: 100%;
            transition: background 0.3s ease-in-out;
        }

        .btn-submit:hover {
            background: #0056b3;
        }

        /* Table Styling */
        .table-container {
            margin-top: 20px;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: center;
            background: white;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
            border-radius: 5px;
        }

        th, td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }

        th {
            background: #007bff;
            color: white;
        }

        tr:hover {
            background: #f1f1f1;
        }

        /* Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Responsive */
        @media (max-width: 768px) {
            .container {
                width: 90%;
                padding: 20px;
            }

            table {
                font-size: 12px;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <h1><i class="fas fa-satellite"></i> Purchased Satellite</h1>

    <!-- Search Form -->
    <form action="purchased.jsp" method="post">
        <div class="input-group position-relative">
            <i class="fas fa-globe"></i>
            <input type="text" name="rec1" placeholder="Satellite Name">
        </div>

        <div class="input-group position-relative">
            <i class="fas fa-cogs"></i>
            <input type="text" name="rec2" placeholder="Satellite Model">
        </div>

        <button type="submit" name="c3" class="btn-submit">Search</button>
    </form>

    <!-- Table -->
    <div class="table-container">
        <table>
            <tr>
                <th colspan="6">DETAILS</th>
            </tr>
            <tr>
                <th>Satellite Name</th>
                <th>Satellite Model</th>
                <th>Quantity</th>
                <th>Quality</th>
                <th>Price</th>
                <th>Product Description</th>
            </tr>

            <%
                if(request.getParameter("c3") != null) {
                    String searchName = request.getParameter("rec1");
                    String searchModel = request.getParameter("rec2");

                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/satelite", "root", "root");
                    
                        String sql = "SELECT satellite_name, satellite_model, quantity, quality, price, product_description FROM satellites WHERE satellite_name LIKE ? AND satellite_model LIKE ?";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, "%" + searchName + "%");
                        pstmt.setString(2, "%" + searchModel + "%");

                        rs = pstmt.executeQuery();

                        while(rs.next()) {
            %>
                            <tr>
                                <td><%= rs.getString("satellite_name") %></td>
                                <td><%= rs.getString("satellite_model") %></td>
                                <td><%= rs.getInt("quantity") %></td>
                                <td><%= rs.getString("quality") %></td>
                                <td><%= rs.getString("price") %></td>
                                <td><%= rs.getString("product_description") %></td>
                            </tr>
            <%
                        }
                    } catch (Exception e) {
                        out.println("<p style='color:red; text-align:center;'>Error: " + e.getMessage() + "</p>");
                    } finally {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    }
                }
            %>
        </table>
    </div>
</div>

</body>
</html>
