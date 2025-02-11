<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Analyser Panel</title>

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
            color: white;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            text-align: center;
            padding: 20px;
        }

        /* Navigation Bar */
        .navbar {
            width: 100%;
            background: rgba(0, 0, 0, 0.8);
            padding: 15px 0;
            display: flex;
            justify-content: center;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1000;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.5);
        }

        .nav-links {
            display: flex;
            gap: 25px;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            padding: 12px 18px;
            font-size: 16px;
            transition: all 0.3s;
            border-radius: 5px;
        }

        .nav-links a:hover {
            background: #007bff;
            transform: scale(1.1);
        }

        /* Main Content */
        .container {
            background: rgba(255, 255, 255, 0.1);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 5px 15px rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            width: 90%;
            max-width: 600px;
            animation: fadeIn 1s ease-in-out;
        }

        h1 {
            font-size: 28px;
            margin-bottom: 15px;
            font-weight: bold;
            text-transform: uppercase;
            color: #00aaff;
        }

        p {
            font-size: 16px;
            line-height: 1.6;
            color: #e0e0e0;
        }

        /* Fade-in Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Responsive Navbar */
        @media (max-width: 600px) {
            .nav-links {
                flex-direction: column;
                align-items: center;
            }

            .nav-links a {
                width: 100%;
                text-align: center;
            }
        }
    </style>
</head>
<body>

    <!-- Navigation Bar -->
    <div class="navbar">
        <div class="nav-links">
            <a href="connect_server.jsp"><i class="fas fa-server"></i> Connect Server</a>
            <a href="behvior.jsp"><i class="fas fa-user-secret"></i> Behaviour</a>
            <a href="purchased_satelite.jsp"><i class="fas fa-satellite-dish"></i> Purchased Satellite</a>
            <a href="products.jsp"><i class="fas fa-box"></i> Products</a>
            <a href="report.jsp"><i class="fas fa-file-alt"></i> Report</a>
            <a href="index.html" class="logout-btn">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </div>

    <!-- Centered Content -->
    <div class="container">
        <h1><i class="fas fa-chart-line"></i> Analyser Panel</h1>
        <p>
            The **Analyser Panel** provides real-time monitoring and detailed insights into satellite data.
            Navigate through different sections to **connect to servers, analyze behavior, and generate reports** 
            efficiently. This platform ensures **seamless management** of satellite-related information.
        </p>
    </div>

</body>
</html>
