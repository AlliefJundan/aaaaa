<?php
require_once('database.php');
// $data = tampildata('notes');
$data = tampildata('peminjaman');
$nomor = 0;
?>
<!doctype html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
    integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">

  <title>Peminjaman</title>
</head>

<body>
  <?php
  session_start();
  if ($_SESSION['status'] <> "login") {
    header("location:login.php?msg=belum_login");
  } else {
    require('navbaruser.php');
  }
  ?>
  <script language="JavaScript" type="text/javascript">
    function kembali(id) {
      if (confirm("Apakah yakin akan mengembalikan barang ini")) {
        window.location.href = 'proses_pengembalian.php?id=' + id;
      }
    }
  </script>
  <div class="container">
    <center>
      <h1>DAFTAR PEMINJAMAN</h1>
    </center>
    <table class="table">
      <thead>
        <tr>
          <th scope="col">No</th>
          <th scope="col">ID Peminjaman</th>
          <th scope="col">Tanggal Pinjam</th>
          <th scope="col">Tanggal Kembali</th>
          <th scope="col">ID Peminjam</th>
          <th scope="col">ID Barang</th>
          <th scope="col">Kode Barang</th>
          <th scope="col">Nama Barang</th>
          <th scope="col">Jumlah Barang</th>
          <th scope="col">Keperluan</th>
          <th scope="col">Status</th>
          <th scope="col">ID Login</th>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($data as $item): ?>
          <?php $nomor++; ?>
          <tr>
            <th scope="row">
              <?php echo $nomor; ?>
            </th>
            <td>
              <?php echo $item['id_peminjaman']; ?>
            </td>
            <td>
              <?php echo $item['tgl_pinjam']; ?>
            </td>
            <td>
              <?php echo $item['tgl_kembali']; ?>
            </td>
            <td>
              <?php echo $item['id_peminjam']; ?>
            </td>
            <td>
              <?php echo $item['id_barang']; ?>
            </td>
            <td>
              <?php echo $item['kode_barang']; ?>
            </td>
            <td>
              <?php echo $item['nama_barang']; ?>
            </td>
            <td>
              <?php echo $item['jml_brg']; ?>
            </td>
            <td>
              <?php echo $item['keperluan']; ?>
            </td>
            <td>
              <?php echo $item['status']; ?>
            </td>
            <td>
              <?php echo $item['id_login']; ?>
            </td>
          </tr>
        <?php endforeach ?>
      </tbody>
    </table>
  </div>
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