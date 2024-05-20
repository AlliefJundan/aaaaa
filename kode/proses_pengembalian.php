<?php
require_once('database.php');

// Mendapatkan data dari parameter GET
$id = $_GET['id'];

// Mendapatkan data pengembalian
$data_pengembalian = kembali('peminjaman', $id);

if ($data_pengembalian) {
    // Memperbarui status peminjaman menjadi 'Dikembalikan' dan menambahkan tanggal kembali
    $koneksi->query("UPDATE peminjaman SET tgl_kembali = NOW(), status = 'Kembali' WHERE id_peminjaman = '$id'");

    // Mendapatkan jumlah yang dikembalikan
    $jumlah_dikembalikan = $data_pengembalian['jumlah'];

    // Mendapatkan kode barang yang dikembalikan
    $kode_barang_dikembalikan = $data_pengembalian['kode_barang'];

    // Mendapatkan jumlah barang yang tersedia saat ini
    $barang = barang($kode_barang_dikembalikan);
    $jumlah_tersedia_sekarang = $barang['jumlah'];

    // Menghitung jumlah baru yang tersedia setelah barang dikembalikan
    $jumlah_baru = $jumlah_tersedia_sekarang + $jumlah_dikembalikan;

    // Memperbarui jumlah barang yang tersedia di tabel barang
    $koneksi->query("UPDATE barang SET jumlah = $jumlah_baru WHERE kode_barang = '$kode_barang_dikembalikan'");
}

// Mengarahkan kembali ke halaman peminjaman
header("location:peminjaman.php");
?>
