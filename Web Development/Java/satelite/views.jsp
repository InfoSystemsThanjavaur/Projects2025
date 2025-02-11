<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Satellite</title>
    
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

        /* Body Styling */
        body {
            background: linear-gradient(to right, #6a11cb, #2575fc);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            text-align: center;
            padding: 20px;
        }

        /* Form Container */
        .container {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
            animation: fadeIn 0.8s ease-in-out;
            width: 100%;
            max-width: 400px;
        }

        /* Fade-in Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Form Title */
        .container_title {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            margin-bottom: 15px;
        }

        /* Input Fields */
        .input_box {
            position: relative;
            margin-bottom: 15px;
        }

        .input_box input, .input_box textarea {
            width: 100%;
            padding: 10px;
            padding-left: 35px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }

        .input_box i {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: #555;
        }

        /* Submit Button */
        .input_box input[type="submit"] {
            background: #2575fc;
            color: white;
            border: none;
            cursor: pointer;
            transition: background 0.3s ease-in-out;
        }

        .input_box input[type="submit"]:hover {
            background: #6a11cb;
        }

        /* Mobile Responsive */
        @media (max-width: 600px) {
            .container {
                width: 90%;
                padding: 25px;
            }
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="container_title"><i class="fas fa-satellite"></i> Satellite Details</div>

        <form action="views.jsp" method="post">
            <div class="input_box">
                <i class="fas fa-globe"></i>
                <input type="text" name="r1" placeholder="Satellite Name" required>
            </div>

            <div class="input_box">
                <i class="fas fa-cogs"></i>
                <input type="text" name="r2" placeholder="Satellite Model" required>
            </div>

            <div class="input_box">
                <i class="fas fa-sort-numeric-up"></i>
                <input type="number" name="r3" placeholder="Quantity" required>
            </div>

            <div class="input_box">
                <i class="fas fa-check-circle"></i>
                <input type="text" name="r4" placeholder="Quality" required>
            </div>

            <div class="input_box">
                <i class="fas fa-dollar-sign"></i>
                <input type="text" name="r5" placeholder="Enter Price" required>
            </div>

            <div class="input_box">
                <i class="fas fa-info-circle"></i>
                <textarea name="r6" placeholder="Enter Product Description" required></textarea>
            </div>

            <div class="input_box">
                <input type="submit" name="s1" value="Submit">
            </div>
        </form>

        <%
            // Handling form submission
            if(request.getParameter("s1") != null) {
                String satelliteName = request.getParameter("r1");
                String satelliteModel = request.getParameter("r2");
                String quantity = request.getParameter("r3");
                String quality = request.getParameter("r4");
                String price = request.getParameter("r5");
                String productDescription = request.getParameter("r6");

                Connection conn = null;
                PreparedStatement pstmt = null;
                
                try {
                    // Database connection
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/satelite", "root", "root");
              
                    // Insert query
                    String sql = "INSERT INTO satellites (satellite_name, satellite_model, quantity, quality, price, product_description) VALUES (?, ?, ?, ?, ?, ?)";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, satelliteName);
                    pstmt.setString(2, satelliteModel);
                    pstmt.setInt(3, Integer.parseInt(quantity));
                    pstmt.setString(4, quality);
                    pstmt.setString(5, price);
                    pstmt.setString(6, productDescription);

                    int rows = pstmt.executeUpdate();
                    if(rows > 0) {
                        out.println("<script>alert('Satellite details inserted successfully!');</script>");
                    } else {
                        out.println("<script>alert('Error inserting data!');</script>");
                    }
                } catch (Exception e) {
                    out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
                } finally {
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                }
            }
        %>
    </div>

</body>
</html>
