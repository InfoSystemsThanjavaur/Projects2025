<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload Delivery</title>

    <!-- Bootstrap & FontAwesome -->
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

        /* Form Container */
        .container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 500px;
            animation: fadeIn 0.8s ease-in-out;
        }

        /* Heading */
        .container_title {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }

        .container_title h1 {
            font-size: 24px;
        }

        /* Input Box */
        .input_box {
            position: relative;
            margin-bottom: 15px;
        }

        .input_box input, 
        .input_box textarea {
            width: 100%;
            padding: 10px;
            padding-left: 40px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            transition: 0.3s;
        }

        .input_box textarea {
            resize: none;
            height: 80px;
        }

        .input_box input:focus, 
        .input_box textarea:focus {
            border-color: #007bff;
            box-shadow: 0px 0px 5px rgba(0, 123, 255, 0.5);
        }

        .input_box i {
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
        }
    </style>
</head>
<body>

<div class="container">
    <div class="container_title">
        <h1><i class="fas fa-truck"></i> UPDATE DELIVERY</h1>
    </div>

    <form action="upldel.jsp" method="post">
        <div class="input_box">
            <i class="fas fa-satellite"></i>
            <input type="text" name="r1" placeholder="Satellite Name" required>
        </div>

        <div class="input_box">
            <i class="fas fa-cogs"></i>
            <input type="text" name="r2" placeholder="Satellite Model" required>
        </div>

        <div class="input_box">
            <i class="fas fa-map-marker-alt"></i>
            <textarea name="r3" placeholder="To Address" required></textarea>
        </div>

        <div class="input_box">
            <i class="fas fa-clock"></i>
            <input type="time" name="r4" required>
        </div>

        <div class="input_box">
            <i class="fas fa-calendar-alt"></i>
            <input type="date" name="r5" required>
        </div>

        <button type="submit" name="s1" class="btn-submit"><i class="fas fa-upload"></i> Submit</button>
    </form>
</div>

<%
    if(request.getParameter("s1") != null) {
        String satelliteName = request.getParameter("r1");
        String satelliteModel = request.getParameter("r2");
        String toAddress = request.getParameter("r3");
        String deliveryTime = request.getParameter("r4");
        String deliveryDate = request.getParameter("r5");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/satelite", "root", "root");

            // SQL Query to insert data
            String sql = "INSERT INTO delivery_details (satellite_name, satellite_model, to_address, delivery_time, delivery_date) VALUES (?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, satelliteName);
            pstmt.setString(2, satelliteModel);
            pstmt.setString(3, toAddress);
            pstmt.setString(4, deliveryTime);
            pstmt.setString(5, deliveryDate);

            int rowsInserted = pstmt.executeUpdate();
            if(rowsInserted > 0) {
                out.println("<script>alert('Delivery details uploaded successfully!');</script>");
            } else {
                out.println("<script>alert('Failed to upload delivery details.');</script>");
            }
        } catch (Exception e) {
            out.println(e);
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }    
    }
%>

</body>
</html>
