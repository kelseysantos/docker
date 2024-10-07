# Contacte para saber mais

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Card de Contato</title>
    <style>
        .card {
            display: flex;
            align-items: center;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            width: 350px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .profile-img {
            border-radius: 50%;
            width: 80px;
            height: 80px;
            margin-right: 20px;
        }
        .info {
            font-family: Arial, sans-serif;
        }
        .info h2 {
            margin: 0;
            font-size: 1.5em;
            color: #333;
        }
        .info p {
            margin: 5px 0;
        }
        .info p span {
            color: #333;
        }
        .info p .mobile {
            color: #008080;
        }
        .info p .email {
            color: #1E90FF;
        }
    </style>
</head>
<body>

<div class="card">
    <img src="profile.jpg" alt="Profile Image" class="profile-img">
    <div class="info">
        <h2>Serviços em TI</h2>
        <p><span>Kelsey Santos</span></p>
        <p>mobile: <span class="mobile">+5565993288276</span></p>
        <p>email: <span class="email">servicosticiuaba@gmail.com</span></p>
    </div>
</div>

</body>
</html>