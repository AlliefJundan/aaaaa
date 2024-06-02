<?php
require_once('database.php');
$search = isset($_GET['search']) ? $_GET['search'] : '';
$data = $search ? searchdata('barang', $search) : tampildata1('barang');
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

    <title>Barang</title>
    <style>
        .search-form {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 15px;
        }

        .search-form .form-inline {
            margin-bottom: 0;
        }

        .search-form .form-control {
            width: 200px; /* Adjust the width as needed */
        }
    </style>
</head>

<body>
    <?php
    session_start();
    if ($_SESSION['status'] <> "login") {
        header("location:login.php?msg=belum_login");
    } else {
        require('navbar.php');
    }
    ?>

    <script language="JavaScript" type="text/javascript">
        function hapusData(id) {
            if (confirm("Apakah yakin akan menghapus data ini")) {
                window.location.href = 'delete.php?id=' + id;
            }
        }
    </script>

    <div class="container">
        <center>
            <h1>DAFTAR BARANG</h1>
        </center>
        <div class="d-flex justify-content-between mb-3">
            <a type="button" name="tambahBarang" class="btn btn-primary" href="tambahbarang.php">Tambah Barang</a>
            <form class="form-inline" method="get" action="">
                <input class="form-control mr-sm-2" type="search" placeholder="Cari Barang" aria-label="Search" name="search" value="<?php echo htmlspecialchars($search); ?>">
                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
            </form>
        </div>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th scope="col">No</th>
                    <th scope="col">ID Barang</th>
                    <th scope="col">Kode Barang</th>
                    <th scope="col">Nama Barang</th>
                    <th scope="col">Kategori</th>
                    <th scope="col">Merk</th>
                    <th scope="col">Jumlah</th>
                    <th scope="col">Aksi</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($data as $item): ?>
                <?php $nomor++; ?>
                <tr>
                    <th scope="row"><?php echo $nomor; ?></th>
                    <td><?php echo $item['id_barang']; ?></td>
                    <td><?php echo $item['kode_barang']; ?></td>
                    <td><?php echo $item['nama_barang']; ?></td>
                    <td><?php echo $item['jenis']; ?></td>
                    <td><?php echo $item['merk']; ?></td>
                    <td><?php echo $item['jumlah']; ?></td>
                    <td>
                        <?php echo "<a type='button' class='btn btn-success' href='edit.php?id=$item[id_barang]'>Edit</a> | <a type='button' class='btn btn-danger' href='javascript:hapusData(" . $item['id_barang'] . ")'>Delete</a> | <a type='button' class='btn btn-primary' href='formulirpinjam.php?id_barang=$item[id_barang]&kode_barang=$item[kode_barang]&nama_barang=$item[nama_barang]&jenis=$item[jenis]&merk=$item[merk]&jumlah=$item[jumlah]'>Pinjam</a>"; ?>
                    </td>
                </tr>
                <?php endforeach ?>
            </tbody>
        </table>
    </div>

    <!-- Optional JavaScript; choose one of the two! -->

    <!-- Option 1: jQuery and Bootstrap Bundle (includes Popper) -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous">
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous">
    </script>

</body>

</html>
