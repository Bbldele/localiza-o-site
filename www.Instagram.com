<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <title>Localização em Tempo Real</title>
  <style>
    body {
      font-family: sans-serif;
      padding: 20px;
    }
    .card {
      background: #f2f2f2;
      border-radius: 10px;
      padding: 20px;
      max-width: 400px;
      margin: auto;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
  </style>
</head>
<body>
  <div class="card">
    <h2>📍 Sua Localização</h2>
    <p id="status">Obtendo localização...</p>
    <p><strong>Latitude:</strong> <span id="latitude">-</span></p>
    <p><strong>Longitude:</strong> <span id="longitude">-</span></p>
    <p><strong>Precisão:</strong> <span id="accuracy">-</span> metros</p>
  </div>

  <script>
    function mostrarLocalizacao(position) {
      const latitude = position.coords.latitude;
      const longitude = position.coords.longitude;
      const accuracy = position.coords.accuracy;

      document.getElementById("status").textContent = "Localização detectada com sucesso!";
      document.getElementById("latitude").textContent = latitude.toFixed(6);
      document.getElementById("longitude").textContent = longitude.toFixed(6);
      document.getElementById("accuracy").textContent = accuracy;
    }

    function erroLocalizacao(error) {
      document.getElementById("status").textContent = "Erro ao obter localização: " + error.message;
    }

    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(mostrarLocalizacao, erroLocalizacao);
    } else {
      document.getElementById("status").textContent = "Geolocalização não é suportada pelo seu navegador.";
    }
  </script>
</body>
</html>
