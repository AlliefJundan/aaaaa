<?php
session_start();
require_once('database.php');

if ($_SESSION['status'] != "login") {
    header("location:login.php?msg=belum_login");
    exit;
}

// Get form data
$id_peminjaman = $_POST['id_peminjaman'];

// Get the peminjaman details
$peminjaman = getPeminjamanById($id_peminjaman);

if ($peminjaman) {
    $id_barang = $peminjaman['id_barang'];
    $jumlah_brg = $peminjaman['jml_brg'];
    $status = $peminjaman['status'];
    
    // Check if the item has already been returned
    if ($status == 'Dikembalikan') {
        header("location:pengembalian.php?id_peminjaman=$id_peminjaman&msg=already_returned");
        exit;
    }

    // Update peminjaman status
    $query_update_peminjaman = "UPDATE peminjaman SET status = 'Kembali', tgl_kembali = NOW() WHERE id_peminjaman = ?";
    $stmt_update_peminjaman = $koneksi->prepare($query_update_peminjaman);

    if (!$stmt_update_peminjaman) {
        die("Error preparing statement: " . $koneksi->error);
    }

    $stmt_update_peminjaman->bind_param("i", $id_peminjaman);

    if (!$stmt_update_peminjaman->execute()) {
        die("Error executing statement: " . $stmt_update_peminjaman->error);
    }

    // Update barang quantity
    $new_jumlah_tersedia = $jumlah_brg + $jumlah_kembali;
    $query_update_barang = "UPDATE barang SET jumlah = jumlah + ? WHERE id_barang = ?";
    $stmt_update_barang = $koneksi->prepare($query_update_barang);

    if (!$stmt_update_barang) {
        die("Error preparing statement: " . $koneksi->error);
    }

    $stmt_update_barang->bind_param("ii", $jumlah_brg, $id_barang);

    if (!$stmt_update_barang->execute()) {
        die("Error executing statement: " . $stmt_update_barang->error);
    }

    header("location:peminjaman.php?msg=pengembalian_sukses");
    exit;
} else {
    header("location:pengembalian.php?id_peminjaman=$id_peminjaman&msg=invalid_peminjaman");
    exit;
}
?>
