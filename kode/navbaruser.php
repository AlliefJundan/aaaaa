<?php
require_once('database.php')
?>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo03"
      aria-controls="navbarTogglerDemo03" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <a class="navbar-brand" href="homeuser.php">Peminjaman</a>

    <div class="collapse navbar-collapse" id="navbarTogglerDemo03">
      <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
      <li class="nav-item">
          <a class="nav-link" href="homeuser.php">Home</span></a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="baranguser.php">Barang</span></a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="peminjamanuser.php">Peminjaman <span class="sr-only">(current)</span></a>
        </li>
      </ul>
      <form class="form-inline my-2 my-lg-0">
        <a class="btn btn-primary" href="logout.php" role="button">Logout</a>
      </form>
    </div>
  </nav>