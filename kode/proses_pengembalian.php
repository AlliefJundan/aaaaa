<?php
require_once('database.php');

// Mendapatkan data dari parameter GET
$id = $_GET['id'];
$jumlah = $_GET['jml_brg'];

// Mendapatkan data pengembalian
$data_pengembalian = kembali('peminjaman', $id, $jml_brg);

if ($data_pengembalian) {
    $koneksi->query("UPDATE peminjaman SET tgl_kembali = NOW(), status = 'Kembali' WHERE id_peminjaman = '$id'");


    $jumlah_dikembalikan = $data_pengembalian['jml_brg'];

   
    $kode_barang_dikembalikan = $data_pengembalian['kode_barang'];


    $barang = barang('id_barang');
    $jumlah_tersedia_sekarang = $barang['jumlah'];


    $jumlah_baru = $jumlah_tersedia_sekarang + $jumlah_dikembalikan;


    $koneksi->query("UPDATE barang SET jumlah = jumlah + $jumlah WHERE kode_barang = '$kode_barang_dikembalikan'");
}


header("location:peminjaman.php");
?>
