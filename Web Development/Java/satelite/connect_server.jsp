<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CONNECT SERVER</title>

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
            margin-bottom: 15px;
        }

        .input_box span {
            display: block;
            font-size: 14px;
            margin-bottom: 5px;
            color: #ddd;
        }

        .input_box input {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: none;
            outline: none;
            font-size: 14px;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            transition: 0.3s;
        }

        .input_box input::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        .input_box input:focus {
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

            .input_box input {
                font-size: 13px;
            }
        }
    </style>
</head>
<body>

    <div class="container">
        <h1><i class="fas fa-server"></i> CONNECT SERVER</h1>
        <form action="connect_server.jsp" method="post">
            <div class="input_box">
                <span class="details">SERVER NAME</span>
                <input type="text" name="server_name" placeholder="Enter Server Name" required>
            </div>

            <div class="input_box">
                <span class="details">SERVER PASSWORD</span>
                <input type="password" name="server_password" placeholder="Enter Server Password" required>
            </div>

            <div class="input_box">
                <span class="details">TEXT</span>
                <input type="text" name="text" placeholder="Enter Text" required>
            </div>

            <div class="input_box">
                <span class="details">RETYPE TEXT</span>
                <input type="text" name="retype_text" placeholder="Retype Text" required>
            </div>

            <div class="input_box">
                <input type="submit" name="submit" value="Submit">
            </div>
        </form>
    </div>

    <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String serverName = request.getParameter("server_name");
            String serverPassword = request.getParameter("server_password");
            String text = request.getParameter("text");
            String retypeText = request.getParameter("retype_text");

            if (!text.equals(retypeText)) {
                out.println("<script>alert('Text and Retype Text do not match!');</script>");
            } else {
                Connection conn = null;
                PreparedStatement pst = null;

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/satelite", "root", "root");
                    String sql = "INSERT INTO connect_server (server_name, server_password, text) VALUES (?, ?, ?)";
                    pst = conn.prepareStatement(sql);
                    pst.setString(1, serverName);
                    pst.setString(2, serverPassword);
                    pst.setString(3, text);

                    int rowsInserted = pst.executeUpdate();
                    if (rowsInserted > 0) {
                        out.println("<script>alert('Server Connected Successfully!');</script>");
                    }
                } catch (Exception e) {
                    out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
                } finally {
                    if (pst != null) pst.close();
                    if (conn != null) conn.close();
                }
            }
        }
    %>

</body>
</html>
