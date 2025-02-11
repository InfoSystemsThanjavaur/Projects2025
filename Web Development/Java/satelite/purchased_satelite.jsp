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
            background: linear-gradient(to right, #0f2027, #203a43, #2c5364);
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

        .input_box {
            position: relative;
            margin-bottom: 15px;
            text-align: left;
        }
        
        .input_box i {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: white;
            font-size: 16px;
            pointer-events: none; /* Prevents clicking the icon */
        }
        
        .input_box input, .input_box textarea {
            width: 100%;
            padding: 10px 15px 10px 40px; /* Added left padding to prevent overlap */
            border-radius: 5px;
            border: none;
            outline: none;
            font-size: 14px;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            transition: 0.3s;
        }
        
        .input_box input:focus, .input_box textarea:focus {
            background: rgba(255, 255, 255, 0.3);
            transform: scale(1.02);
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
        <h1><i class="fas fa-satellite"></i> SATELLITE PURCHASE</h1>
        <form action="purchased_satelite.jsp" method="post">
            <div class="input_box">
                <i class="fas fa-satellite"></i>
                <span class="details">SATELLITE NAME</span>
                <input type="text" name="satellite_name" placeholder="Enter Satellite Name" required>
            </div>

            <div class="input_box">
                <i class="fas fa-cogs"></i>
                <span class="details">SATELLITE MODEL</span>
                <input type="text" name="satellite_model" placeholder="Enter Satellite Model" required>
            </div>

            <div class="input_box">
                <i class="fas fa-box"></i>
                <span class="details">QUANTITY</span>
                <input type="text" name="quantity" placeholder="Enter Quantity" required>
            </div>

            <div class="input_box">
                <i class="fas fa-map-marker-alt"></i>
                <span class="details">ADDRESS</span>
                <textarea name="address" placeholder="Enter Address" required></textarea>
            </div>

            <div class="input_box">
                <i class="fas fa-phone"></i>
                <span class="details">PHONE NUMBER</span>
                <input type="text" name="phone_number" placeholder="Enter Phone Number" required>
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
            String quantity = request.getParameter("quantity");
            String address = request.getParameter("address");
            String phoneNumber = request.getParameter("phone_number");

            Connection conn = null;
            PreparedStatement pst = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/satelite", "root", "root");
               
                String sql = "INSERT INTO purchased_satellites (satellite_name, satellite_model, quantity, address, phone_number) VALUES (?, ?, ?, ?, ?)";
                
                pst = conn.prepareStatement(sql);
                pst.setString(1, satelliteName);
                pst.setString(2, satelliteModel);
                pst.setString(3, quantity);
                pst.setString(4, address);
                pst.setString(5, phoneNumber);

                int rowsInserted = pst.executeUpdate();
                if (rowsInserted > 0) {
                    out.println("<script>alert('Satellite purchase details submitted successfully!');</script>");
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
