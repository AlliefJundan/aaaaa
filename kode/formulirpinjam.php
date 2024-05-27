<!doctype html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
    crossorigin="anonymous">
  <!-- Di dalam tag <head> sebelum tag <body> -->
  <script>
    var jumlahTersediaSekarang = 0; // Variabel global untuk menyimpan jumlah barang saat halaman dimuat

    window.onload = function () {
      document.getElementById("form_peminjaman").reset();
      getBarangDetails();
      jumlahTersediaSekarang = parseInt(document.getElementById("jumlah_tersedia").value); // Simpan nilai jumlah tersedia saat halaman dimuat
    }

    // Fungsi cekJumlah tetap sama seperti sebelumnya

    function cekJumlah() {
      var jumlah_dipinjam = parseInt(document.getElementById("jumlah").value);

      if (jumlah_dipinjam <= 0) {
        alert("Jumlah yang dipinjam harus lebih dari 0.");
        return false;
      }

      if (jumlah_dipinjam > jumlahTersediaSekarang) { // Gunakan variabel global jumlahTersediaSekarang
        alert("Jumlah yang dipinjam melebihi jumlah yang tersedia.");
        return false;
      }

      return true;
    }
  </script>

  <title>Formulir Peminjaman Barang</title>
</head>

<body>
  <?php
  session_start();
  if ($_SESSION['status'] != "login") {
    header("location:login.php?msg=belum_login");
    exit;
  } else {
    require ('navbar.php');
  }
  ?>
  <div class="container">
    <div class="row">
      <div class="col-md-4"></div>
      <div class="col-md-4">
        <h2 align="center">Formulir Peminjaman Barang</h2>
        <form method="post" action="proses_peminjaman.php" id="form_peminjaman" onsubmit="return cekJumlah()">
          <label for="kode_barang">Pilih Kode Barang:</label>
          <select class="form-control" name="kode_barang" id="kode_barang" onchange="getBarangDetails()">
            <option value="">Kosong</option> <!-- Tambahkan opsi "kosong" di sini -->
            <?php
            require_once ('database.php');
            $result = getAllBarang();
            if ($result->num_rows > 0) {
              while ($row = $result->fetch_assoc()) {
                echo "<option value='" . $row["kode_barang"] . "'>" . $row["kode_barang"] . "</option>";
              }
            } else {
              echo "<option value='' disabled>Tidak ada barang tersedia</option>"; // Opsi "kosong" tidak dapat dipilih jika tidak ada barang tersedia
            }
            ?>
          </select>

          <div class="form-group">
            <label for="nama_brg">Nama Barang:</label>
            <input type="text" class="form-control" id="nama_brg" name="nama_barang" readonly>
          </div>
          <div class="form-group">
            <label for="kategori">Jenis:</label>
            <input type="text" class="form-control" id="kategori" name="jenis" readonly>
          </div>
          <div class="form-group">
            <label for="merk">Merk:</label>
            <input type="text" class="form-control" id="merk" name="merk" readonly>
          </div>
          <div class="form-group">
            <label for="jumlah_tersedia">Jumlah Tersedia:</label>
            <input type="text" class="form-control" id="jumlah_tersedia" name="jumlah_tersedia" readonly>
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
    <script>
      window.onload = function () {
        document.getElementById("form_peminjaman").reset();
        getBarangDetails();
      }

      function getBarangDetails() {
        var kode_barang = document.getElementById("kode_barang").value;
        var xhr = new XMLHttpRequest();
        xhr.open("GET", "detailbarang.php?kode_barang=" + kode_barang, true);
        xhr.onreadystatechange = function () {
          if (xhr.readyState == 4 && xhr.status == 200) {
            var barang = JSON.parse(xhr.responseText);
            document.getElementById("nama_brg").value = barang.nama_barang;
            document.getElementById("kategori").value = barang.jenis;
            document.getElementById("merk").value = barang.merk;
            document.getElementById("jumlah_tersedia").value = barang.jumlah;
          }
        };
        xhr.send();
      }

      function cekJumlah() {
        var jumlah_tersedia = parseInt(document.getElementById("jumlah_tersedia").value);
        var jumlah_dipinjam = parseInt(document.getElementById("jumlah").value);

        if (jumlah_dipinjam <= 0) {
          alert("Jumlah yang dipinjam harus lebih dari 0.");
          return false;
        }

        if (jumlah_dipinjam > jumlah_tersedia) {
          alert("Jumlah yang dipinjam melebihi jumlah yang tersedia.");
          return false;
        }

        return true;
      }
    </script>
</body>

</html>