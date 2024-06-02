<?php
session_start();
if ($_SESSION['status'] != "login") {
  header("location:login.php?msg=belum_login");
  exit;
} else {
  require('navbar.php');
}

require_once('database.php');

$id_peminjaman = isset($_GET['id_peminjaman']) ? $_GET['id_peminjaman'] : '';
$peminjaman = getPeminjamanById($id_peminjaman);

// Mengambil data dari hasil query
if ($peminjaman) {
  $id_barang = $peminjaman['id_barang'];
  $jumlah_brg = $peminjaman['jml_brg'];
  $id_peminjam = $peminjaman['id_peminjam'];
  $status = $peminjaman['status'];
} else {
  // Jika data peminjaman tidak ditemukan, atur default value
  $id_barang = '';
  $jumlah_brg = '';
  $id_peminjam = '';
  $status = '';
}
?>
<!doctype html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
    crossorigin="anonymous">
  <title>Formulir Pengembalian Barang</title>
</head>

<body>
  <div class="container">
    <div class="row">
      <div class="col-md-4"></div>
      <div class="col-md-4">
        <h2 align="center">Formulir Pengembalian Barang</h2>
        <?php if ($status == 'Kembali'): ?>
          <div class="alert alert-info" role="alert">
            Barang ini sudah dikembalikan. Anda akan diarahkan ke halaman peminjaman dalam 3 detik.
          </div>
          <script>
            setTimeout(function() {
              window.location.href = 'peminjaman.php';
            }, 3000);
          </script>
        <?php else: ?>
          <form method="post" action="proses_pengembalian.php" id="form_pengembalian">
            <div class="form-group">
              <label for="id_peminjaman">ID Peminjaman</label>
              <input type="text" class="form-control" id="id_peminjaman" name="id_peminjaman" value="<?php echo $id_peminjaman; ?>" readonly>
            </div>  
            <div class="form-group">
              <label for="id_peminjam">ID Peminjam:</label>
              <input type="text" class="form-control" id="id_peminjam" name="id_peminjam" value="<?php echo $id_peminjam; ?>" readonly>
            </div>
            <div class="form-group">
              <label for="kode_barang">ID Barang</label>
              <input type="text" class="form-control" id="kode_barang" name="kode_barang" value="<?php echo $id_barang; ?>" readonly>
            </div>
            <div class="form-group">
              <label for="jumlah_brg">Jumlah Barang:</label>
              <input type="text" class="form-control" id="jumlah_brg" name="jumlah_brg" value="<?php echo $jumlah_brg; ?>" readonly>
            </div>
            <div class="form-group">
              <label for="status">Status</label>
              <input type="text" class="form-control" id="status" name="status" value="<?php echo $status; ?>" readonly>
            </div>
            <button type="submit" class="btn btn-primary">Kembalikan</button>
          </form>
        <?php endif; ?>
      </div>
    </div>
  </div>
</body>

</html>
