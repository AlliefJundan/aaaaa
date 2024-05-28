<?php
header("Access-Control-Allow-Origin: *");


$conn = mysqli_connect("localhost", "root", "", "sas");

$id = $_POST['id_barang'];
$nama = $_POST['nama_barang'];
$kode = $_POST['kode_barang'];
$merk = $_POST['merk'];
$jenis = $_POST['jenis'];
$jumlah = $_POST['jumlah'];

$query = "UPDATE barang SET kode_barang='$kode', nama_barang='$nama', merk='$merk', jenis='$jenis', jumlah='$jumlah' WHERE id_barang='$id'";
$data = mysqli_query($conn, $query);

if ($data) {
    echo json_encode([
        'success' => true,
        'pesan' => 'Sukses'
    ]);
} else {
    echo json_encode([
        'success' => false,
        'pesan' => 'Gagal memperbarui data'
    ]);
}
?>
