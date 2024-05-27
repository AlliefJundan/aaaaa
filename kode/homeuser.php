<!doctype html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
    integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">

  <title>Home</title>

  <style>
    html, body {
      height: 100%;
      background-color: #808080; /* Set background color to gray */
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
  <?php
  session_start();
  if ($_SESSION['status'] != "login") {
    header("location:login.php?msg=belum_login");
  } else {
    require('navbaruser.php');
  }
  ?>

  <div class="content">
    <center>
      <div class="jumbotron bg-dark">
        <div class="container">
          <h1 class="display-4 text-white">Peminjaman Barang</h1>
          <p class="lead text-white">
            <b> Lorem ipsum dolor sit amet, consectetur adipiscing elit. </b>
          </p>
          <a role="button" class="btn btn-secondary btn-lg" href="baranguser.php">Barang</a>
        </div>
      </div>
    </center>
  </div>

  <footer class="footer mt-auto py-3 bg-dark">
    <div class="container">
      <span class="text-muted">Place sticky footer content here.</span>
    </div>
  </footer>

  <!-- Optional JavaScript; choose one of the two! -->

  <!-- Option 1: jQuery and Bootstrap Bundle (includes Popper) -->
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
    integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
    crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct"
    crossorigin="anonymous"></script>

  <!-- Option 2: Separate Popper and Bootstrap JS -->
  <!--
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>
  -->
</body>

</html>
