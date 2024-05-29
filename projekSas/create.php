<?php
header("Access-Control-Allow-Origin: *");

// Koneksi ke database
$conn = mysqli_connect("localhost", "root", "", "sas");

// Ambil data dari POST request
$id_barang = $_POST['id_barang'];
$kode_barang = $_POST['kode_barang'];
$nama_barang = $_POST['nama_barang'];
$merk = $_POST['merk'];
$jenis = $_POST['jenis'];
$jumlah = $_POST['jumlah'];

// Query untuk menyimpan data barang ke dalam database
$query = "INSERT INTO barang (id_barang, kode_barang, nama_barang, merk, jenis, jumlah) 
          VALUES ('$id_barang', '$kode_barang', '$nama_barang', '$merk', '$jenis', '$jumlah')";

// Jalankan query
$data = mysqli_query($conn, $query);

// Buat respons JSON
if ($data) {
    echo json_encode([
        'success' => true,
        'pesan' => 'Sukses'
    ]);
} else {
    echo json_encode([
        'success' => false,
        'pesan' => 'Gagal menyimpan data barang'
    ]);
}
?>
