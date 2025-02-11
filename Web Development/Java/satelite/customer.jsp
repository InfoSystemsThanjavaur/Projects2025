<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Registration</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #74ebd5, #ACB6E5);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
            text-align: center;
            max-width: 400px;
            width: 100%;
            animation: fadeIn 1s ease-in-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        h1 {
            color: #333;
        }
        .input_box {
            position: relative;
            margin-bottom: 15px;
            text-align: left;
        }
        .input_box input, .input_box textarea {
            width: calc(100% - 40px);
            padding: 10px;
            padding-left: 35px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }
        .input_box i {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: #777;
        }
        .btn-container {
            display: flex;
            justify-content: center;
        }
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            background: #007BFF;
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
        }
        input[type="submit"]:hover {
            background: #0056b3;
        }
        .one {
            text-align: left;
            margin-top: 10px;
        }
        @media (max-width: 600px) {
            .container {
                width: 90%;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Customer Registration</h1>
    <form action="customer.jsp" method="post">
        <div class="input_box">
            <i class="fas fa-user"></i>
            <input type="text" name="r1" required placeholder="Enter Customer Name">
        </div>
        <div class="input_box">
            <i class="fas fa-id-badge"></i>
            <input type="text" name="r2" required placeholder="Enter Customer ID">
        </div>
        <div class="input_box">
            <i class="fas fa-map-marker-alt"></i>
            <textarea name="r3" required placeholder="Enter Location"></textarea>
        </div>
        <div class="input_box">
            <i class="fas fa-phone"></i>
            <input type="text" name="r4" required placeholder="Enter Phone Number">
        </div>
        <div class="input_box">
            <i class="fas fa-envelope"></i>
            <input type="email" name="r5" required placeholder="Enter Email">
        </div>
        <div class="one">
            <span class="details">Already Purchased</span><br>
            <input type="radio" name="r6" value="yes" required> Yes
            <input type="radio" name="r6" value="no"> No
        </div><br>
        <div class="btn-container">
            <input type="submit" name="s1" value="Submit">
        </div>
    </form>
</div>

</body>
</html>
