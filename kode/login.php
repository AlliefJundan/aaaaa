<?php
require_once('database.php');
session_start();

if (isset($_POST['masuk'])) {
    $username = $_POST['username'];
    $password = $_POST['password'];

    if (cek_login($username, $password)) {
        $_SESSION['username'] = $username;
        $_SESSION['status'] = 'login';
        
        // Mendapatkan ID user berdasarkan username
        $id_user = get_id_user($username); // Anggap get_id_user adalah fungsi yang mengembalikan ID user berdasarkan username
        
        $_SESSION['id_user'] = $id_user;

        $_SESSION['role'] = cek_role($username); // Anggap cek_role adalah fungsi yang mengembalikan role user berdasarkan username

        if ($_SESSION['role'] == 'admin') {
            header("location:home.php");
        } else {
            header('location:homeuser.php');
        }
    } else {
        header("location:login.php?msg=gagal");
    }
}
?>

<!doctype html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" crossorigin="anonymous">
</head>

<body>
  <div class="container pt-5" align="center">
    <div class="row">
      <div class="col-md-4"></div>
      <div class="col-md-4">
        <div class="card">
          <div class="card-header">
            <h1 class="mb-0" align="center">PEMINJAMAN <span class="text-primary">LOGIN</span></h1>
          </div>
          <div class="card-body">
            <?php if (isset($_GET['msg']) && $_GET['msg'] == 'gagal'): ?>
                <div class="alert alert-danger" role="alert">Invalid username or password!</div>
            <?php endif; ?>
            <form action="" method="POST">
              <div class="form-group">
                <input type="text" class="form-control" name="username" placeholder="Username" required>
              </div>
              <div class="form-group">
                <input type="password" class="form-control" name="password" placeholder="Password" required>
              </div>
              <div class="form-group form-check">
                <input type="checkbox" class="form-check-input" id="exampleCheck1">
                <label class="form-check-label" for="exampleCheck1">Remember Me</label>
              </div>
              <button type="submit" name="masuk" class="btn btn-primary btn-lg btn-block">LOGIN</button>
            </form>
          </div>
        </div>
      </div>
      <div class="col-md-4"></div>
    </div>
  </div>
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>

</html>
