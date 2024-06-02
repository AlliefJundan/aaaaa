<?php
require_once('database.php');
error_reporting(E_ALL);
ini_set('display_errors', 1);

session_start();

if ($_SESSION['status'] != "login") {
    header("location:login.php?msg=belum_login");
    exit;
}

$username = $_SESSION['username'];
?>

<!doctype html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" crossorigin="anonymous">
  <title>Home</title>
  <style>
    html, body {
      height: 100%;
      background-color: #808080;
    }
    body {
      display: flex;
      flex-direction: column;
    }
    .content {
      flex: 1;
    }
    .footer {
      flex-shrink: 0;
    }
  </style>
</head>

<body>
  <?php require('navbaruser.php'); ?>

  <div class="content">
    <center>
      <div class="jumbotron bg-dark">
        <div class="container">
          <h1 class="display-4 text-white">Peminjaman Barang</h1>
          <p class="lead text-white">
            <b>Selamat Datang, <?php echo htmlspecialchars($username); ?>!</b>
          </p>
          <a role="button" class="btn btn-secondary btn-lg" href="baranguser.php">Barang</a>
        </div>
      </div>
    </center>
  </div>

   <!-- Your existing content -->

   <footer class="footer mt-auto py-3 bg-dark">
    <div class="container">
      <?php
      if ($_SESSION['status'] == "login") {
        echo "<br><span class='text-white'>Username: " . $_SESSION['username'] . "</span><br>";
        echo "<span class='text-white'>ID User: " . $_SESSION['id_user'] . "</span>";
      }
      ?>
    </div>
  </footer>

  <!-- Your existing scripts -->

</body>
</html>


  <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>

</html>
