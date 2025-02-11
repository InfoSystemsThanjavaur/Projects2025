<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VIEW SATELLITE</title>

    <!-- FontAwesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <style>
        /* Reset Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        /* Background */
        body {
            background: linear-gradient(to right, #141e30, #243b55);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: white;
            padding: 20px;
        }

        /* Form Container */
        .container {
            background: rgba(255, 255, 255, 0.1);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 5px 15px rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
            width: 90%;
            max-width: 400px;
            text-align: center;
            animation: fadeIn 1s ease-in-out;
        }

        .container h1 {
            font-size: 24px;
            margin-bottom: 20px;
            text-transform: uppercase;
            color: #00aaff;
        }

        /* Form Styling */
        .input_box {
            position: relative;
            margin-bottom: 15px;
            text-align: left;
        }

        .input_box span {
            display: block;
            font-size: 14px;
            margin-bottom: 5px;
            color: #ddd;
        }

        .input_box input, .input_box textarea {
            width: 100%;
            padding: 10px 40px;
            border-radius: 5px;
            border: none;
            outline: none;
            font-size: 14px;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            transition: 0.3s;
        }

        .input_box input::placeholder, .input_box textarea::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        .input_box input:focus, .input_box textarea:focus {
            background: rgba(255, 255, 255, 0.3);
            transform: scale(1.02);
        }

        .input_box textarea {
            resize: none;
            height: 80px;
        }

        /* Icons */
        .input_box i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: white;
            font-size: 14px;
        }

        .input_box input, .input_box textarea {
            padding-left: 35px;
        }

        .input_box input[type="submit"] {
            background: #007bff;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
            border: none;
            padding: 12px;
        }

        .input_box input[type="submit"]:hover {
            background: #0056b3;
            transform: scale(1.05);
        }

        /* Fade-in Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Responsive Design */
        @media (max-width: 500px) {
            .container {
                width: 100%;
                padding: 20px;
            }

            .input_box input, .input_box textarea {
                font-size: 13px;
            }
        }
    </style>
</head>
<body>

    <div class="container">
        <h1><i class="fas fa-satellite"></i> BEHAVIOUR</h1>
        <form action="behavior.jsp" method="post">
            <div class="input_box">
                <i class="fas fa-user"></i>
                <span class="details">CUSTOMER NAME</span>
                <input type="text" name="customer_name" placeholder="Enter Customer Name" required>
            </div>

            <div class="input_box">
                <i class="fas fa-id-card"></i>
                <span class="details">CUSTOMER ID</span>
                <input type="text" name="customer_id" placeholder="Enter Customer ID" required>
            </div>

            <div class="input_box">
                <i class="fas fa-satellite-dish"></i>
                <span class="details">PURCHASED SATELLITE</span>
                <input type="text" name="purchased_satellite" placeholder="Enter Quantity" required>
            </div>

            <div class="input_box">
                <i class="fas fa-comment"></i>
                <span class="details">FEEDBACK</span>
                <textarea name="feedback" placeholder="Enter Feedback" required></textarea>
            </div>

            <div class="input_box">
                <input type="submit" name="submit" value="Submit">
            </div>
        </form>
    </div>

    <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String customerName = request.getParameter("customer_name");
            String customerId = request.getParameter("customer_id");
            String purchasedSatellite = request.getParameter("purchased_satellite");
            String feedback = request.getParameter("feedback");

            Connection conn = null;
            PreparedStatement pst = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/satelite", "root", "root");
                
                // Insert Data into Table
                String sql = "INSERT INTO behavior (customer_name, customer_id, purchased_satellite, feedback) VALUES (?, ?, ?, ?)";
                
                pst = conn.prepareStatement(sql);
                pst.setString(1, customerName);
                pst.setString(2, customerId);
                pst.setString(3, purchasedSatellite);
                pst.setString(4, feedback);

                int rowsInserted = pst.executeUpdate();
                if (rowsInserted > 0) {
                    out.println("<script>alert('Behavior details submitted successfully!');</script>");
                }
            } catch (Exception e) {
                out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
            } finally {
                if (pst != null) pst.close();
                if (conn != null) conn.close();
            }
        }
    %>

</body>
</html>
