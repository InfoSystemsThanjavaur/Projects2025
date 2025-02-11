<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Server Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <!-- FontAwesome for Icons -->
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        body {
            background: #1a1a2e;
            color: white;
            height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .navbar {
            width: 100%;
            background: #0f3460;
            display: flex;
            justify-content: center;
            padding: 15px 0;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1000;
            box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.5);
        }

        .nav-links {
            display: flex;
            gap: 20px;
            list-style: none;
        }

        .nav-links li {
            display: inline;
        }

        .nav-links li a {
            text-decoration: none;
            color: white;
            font-size: 16px;
            font-weight: bold;
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 10px 15px;
            border-radius: 5px;
            transition: background 0.3s, transform 0.2s;
        }

        .nav-links li a i {
            font-size: 18px;
        }

        .nav-links li a:hover {
            background: #e94560;
            transform: scale(1.1);
        }

        .container {
            background: rgba(255, 255, 255, 0.1);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 0px 20px rgba(0, 255, 255, 0.5);
            text-align: center;
            max-width: 500px;
            width: 100%;
            margin-top: 80px;
            animation: fadeIn 1s ease-in-out;
        }

        h1 {
            font-size: 28px;
            font-weight: bold;
            text-transform: uppercase;
            margin-bottom: 20px;
            color: #e94560;
        }

        .content {
            font-size: 16px;
            opacity: 0.9;
            margin-bottom: 10px;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .logout-btn {
            color: white;
            font-size: 16px;
            font-weight: bold;
            padding: 10px 15px;
            border-radius: 5px;
            transition: background 0.3s, transform 0.2s;
            background: #e94560;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .logout-btn:hover {
            background: #ff5733;
            transform: scale(1.1);
        }

        @media (max-width: 768px) {
            .nav-links {
                flex-direction: column;
                gap: 10px;
            }
            .container {
                width: 90%;
            }
        }
    </style>
</head>
<body>

<nav class="navbar">
    <ul class="nav-links">
        <li><a href="customer.jsp"><i class="fas fa-user"></i> CUSTOMER</a></li>
        <li><a href="ordsat.jsp"><i class="fas fa-satellite"></i> ORDER SATELLITE</a></li>
        <li><a href="addpro.jsp"><i class="fas fa-box-open"></i> VIEW PRODUCTS</a></li>
        <li><a href="checkb.jsp"><i class="fas fa-chart-line"></i> CHECK BEHAVIOUR</a></li>
        <li><a href="dailysales.jsp"><i class="fas fa-dollar-sign"></i> DAILY SALES</a></li>
        <a href="index.html" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
    </ul>
</nav>

<div class="container">
    <h1>SERVER PANEL</h1>
    <p class="content">Manage customers, orders, products, and sales efficiently.</p>
</div>

</body>
</html>
