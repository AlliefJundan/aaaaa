<?php
require_once('database.php');

$id_barang = $_POST['kode_barang'];
$no_identitas = $_POST['login'];
$id_login = $_POST['login'];
$jumlah = $_POST['jumlah'];
$keperluan = $_POST['keperluan'];

$barang = barang($id_barang);

if ($barang !== null) {
    $jumlah_tersedia = $barang['jumlah'];

    if ($jumlah_tersedia >= $jumlah) {
        $jumlah_tersedia_baru = $jumlah_tersedia - $jumlah;
        $koneksi->query("UPDATE barang SET jumlah = $jumlah_tersedia_baru WHERE kode_barang = '$id_barang'");

        $sql = "INSERT INTO peminjaman (`tgl_pinjam`, `id_peminjam`, `kode_brg`, `jml_brg`, `keperluan`, `status`, `id_login`)
                VALUES (NOW(), '$no_identitas', '$id_barang', '$jumlah', '$keperluan', 'Dipinjam', '$id_login')";

        if ($koneksi->query($sql) === TRUE) {
            header ("location:peminjaman.php");
        } else {
            echo "Error: " . $sql . "<br>" . $koneksi->error;
        }
    } else {
        echo "Jumlah yang dipinjam melebihi jumlah yang tersedia.";
        
    }
} else {
    echo "Barang tidak ditemukan.";
}

$koneksi->close();
?>