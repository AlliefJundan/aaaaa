<?php
session_start();
if ($_SESSION['status'] != "login") {
  header("location:login.php?msg=belum_login");
  exit;
} else {
  require('navbar.php');
}

$id_barang = isset($_GET['id_barang']) ? $_GET['id_barang'] : '';
$kode_barang = isset($_GET['kode_barang']) ? $_GET['kode_barang'] : '';
$nama_barang = isset($_GET['nama_barang']) ? $_GET['nama_barang'] : '';
$jenis = isset($_GET['jenis']) ? $_GET['jenis'] : '';
$merk = isset($_GET['merk']) ? $_GET['merk'] : '';
$jumlah = isset($_GET['jumlah']) ? $_GET['jumlah'] : '';
?>
<!doctype html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
    crossorigin="anonymous">
  <script>
    var jumlahTersediaSekarang = <?php echo $jumlah; ?>; // Use the initial jumlah from PHP

    function cekJumlah() {
      var jumlah_dipinjam = parseInt(document.getElementById("jumlah").value);

      if (jumlah_dipinjam <= 0) {
        alert("Jumlah yang dipinjam harus lebih dari 0.");
        return false;
      }

      if (jumlah_dipinjam > jumlahTersediaSekarang) {
        alert("Jumlah yang dipinjam melebihi jumlah yang tersedia.");
        return false;
      }

      return true;
    }
  </script>

  <title>Formulir Peminjaman Barang</title>
</head>

<body>
  <div class="container">
    <div class="row">
      <div class="col-md-4"></div>
      <div class="col-md-4">
        <h2 align="center">Formulir Peminjaman Barang</h2>
        <form method="post" action="proses_peminjaman.php" id="form_peminjaman" onsubmit="return cekJumlah()">
          <div class="form-group">
            <label for="id_barang">ID Barang</label>
            <input type="text" class="form-control" id="id_barang" name="id_barang" value="<?php echo $id_barang; ?>" readonly>
          </div>
          <div class="form-group">
            <label for="kode_barang">Kode Barang</label>
            <input type="text" class="form-control" id="kode_barang" name="kode_barang" value="<?php echo $kode_barang; ?>" readonly>
          </div>
          <div class="form-group">
            <label for="nama_brg">Nama Barang:</label>
            <input type="text" class="form-control" id="nama_brg" name="nama_barang" value="<?php echo $nama_barang; ?>" readonly>
          </div>
          <div class="form-group">
            <label for="kategori">Jenis:</label>
            <input type="text" class="form-control" id="kategori" name="jenis" value="<?php echo $jenis; ?>" readonly>
          </div>
          <div class="form-group">
            <label for="merk">Merk:</label>
            <input type="text" class="form-control" id="merk" name="merk" value="<?php echo $merk; ?>" readonly>
          </div>
          <div class="form-group">
            <label for="jumlah_tersedia">Jumlah Tersedia:</label>
            <input type="text" class="form-control" id="jumlah_tersedia" name="jumlah_tersedia" value="<?php echo $jumlah; ?>" readonly>
          </div>
          <div class="form-group">
            <label for="login">ID Peminjam:</label>
            <input type="number" class="form-control" id="login" name="login" required>
          </div>
          <div class="form-group">
            <label for="jumlah">Jumlah:</label>
            <input type="number" class="form-control" id="jumlah" min="1" name="jumlah" required>
          </div>
          <div class="form-group">
            <label for="keperluan">Keperluan:</label>
            <input type="text" class="form-control" id="keperluan" name="keperluan" required>
          </div>
          <button type="submit" class="btn btn-primary" value='pinjam'>Pinjam</button>
        </form>
      </div>
    </div>
  </div>
</body>

</html>
