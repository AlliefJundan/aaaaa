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

    // Debugging statements to track values
    error_log("ID Barang: " . $id_barang);
    error_log("Jumlah Tersedia: " . $jumlah_tersedia);
    error_log("Jumlah Diminta: " . $jumlah);

    if ($jumlah_tersedia >= $jumlah) {
        $jumlah_tersedia_baru = $jumlah_tersedia - $jumlah;

        // Debugging before updating
        error_log("Updating Jumlah Tersedia to: " . $jumlah_tersedia_baru);
        
        if ($koneksi->query("UPDATE barang SET jumlah = $jumlah_tersedia_baru WHERE kode_barang = '$id_barang'") === TRUE) {
            error_log("Jumlah Tersedia Baru: " . $jumlah_tersedia_baru);
        } else {
            error_log("Error Updating: " . $koneksi->error);
        }

        $sql = "INSERT INTO peminjaman (`tgl_pinjam`, `id_peminjam`, `kode_brg`, `jml_brg`, `keperluan`, `status`, `id_login`)
                VALUES (NOW(), '$no_identitas', '$id_barang', '$jumlah', '$keperluan', 'Dipinjam', '$id_login')";

        if ($koneksi->query($sql) === TRUE) {
            header("location:peminjaman.php");
            exit;
        } else {
            error_log("Error Inserting: " . $koneksi->error);
        }
    } else {
        echo "Jumlah yang dipinjam melebihi jumlah yang tersedia.";
    }
} else {
    echo "Barang tidak ditemukan.";
}

$koneksi->close();
?>
