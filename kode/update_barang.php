<?php
require_once ("database.php");

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['update'])) {
    $id = $_POST['id_barang'];
    $kode_brg = $_POST['kode_brg'];
    $nama_brg = $_POST['nama_brg'];
    $kategori = $_POST['kategori'];
    $merk = $_POST['merk'];
    $jumlah = $_POST['jumlah'];

    $query = "UPDATE barang SET kode_barang='$kode_brg', nama_barang='$nama_brg', jenis='$kategori', merk='$merk', jumlah=$jumlah WHERE id_barang=$id";

    if ($koneksi->query($query) === TRUE) {
        header ("location:barang.php");
    } else {
        echo "Error: " . $query . "<br>" . $koneksi->error;
    }
} else {
    echo "Permintaan tidak valid.";
}

$koneksi->close();
?>