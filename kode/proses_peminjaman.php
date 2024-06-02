<?php
session_start();
require_once('database.php');

if ($_SESSION['status'] != "login") {
    header("location:login.php?msg=belum_login");
    exit;
}

// Get form data
$id_barang = $_POST['id_barang'];
$kode_barang = $_POST['kode_barang'];
$nama_barang = $_POST['nama_barang'];
$jenis = $_POST['jenis'];
$merk = $_POST['merk'];
$jumlah_tersedia = $_POST['jumlah_tersedia'];
$login = $_POST['login'];
$jumlah = $_POST['jumlah'];
$keperluan = $_POST['keperluan'];

// Validate form data
if ($jumlah <= 0 || $jumlah > $jumlah_tersedia) {
    header("location:formulirpinjam.php?id_barang=$id_barang&nama_barang=$nama_barang&jenis=$jenis&merk=$merk&jumlah=$jumlah_tersedia&error=invalid_quantity");
    exit;
}

// Update the inventory
$new_jumlah_tersedia = $jumlah_tersedia - $jumlah;
$query_update_barang = "UPDATE barang SET jumlah = ? WHERE id_barang = ?";
$stmt_update_barang = $koneksi->prepare($query_update_barang);

if (!$stmt_update_barang) {
    die("Error preparing statement: " . $koneksi->error);
}

$stmt_update_barang->bind_param("ii", $new_jumlah_tersedia, $id_barang);

if (!$stmt_update_barang->execute()) {
    die("Error executing statement: " . $stmt_update_barang->error);
}

// Insert into peminjaman table
$query_insert_peminjaman = "INSERT INTO peminjaman (id_barang, kode_brg, id_peminjam, jml_brg, keperluan, status, tgl_pinjam, id_login) VALUES (?, ?, ?, ?, ?, 'Dipinjam', NOW(), ?)";
$stmt_insert_peminjaman = $koneksi->prepare($query_insert_peminjaman);

if (!$stmt_insert_peminjaman) {
    die("Error preparing statement: " . $koneksi->error);
}

$stmt_insert_peminjaman->bind_param("issisi", $id_barang, $kode_barang, $login, $jumlah, $keperluan, $login);

if (!$stmt_insert_peminjaman->execute()) {
    die("Error executing statement: " . $stmt_insert_peminjaman->error);
}

header("location:barang.php?msg=peminjaman_sukses");
exit;
?>
