<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

$conn = mysqli_connect("localhost", "root", "", "sas");

if (!$conn) {
    echo json_encode([
        'success' => false,
        'pesan' => 'Failed to connect to database'
    ]);
    exit;
}

$id_barang = $_POST['id_barang'];
$kode_barang = $_POST['kode_barang'];
$nama_barang = $_POST['nama_barang'];
$login = $_POST['login'];
$jumlah = $_POST['jumlah'];
$keperluan = $_POST['keperluan'];

$kurang = "UPDATE barang SET jumlah = jumlah - '$jumlah' WHERE id_barang = '$id_barang'";
$kurang_result = mysqli_query($conn, $kurang);

if (!$kurang_result) {
    echo json_encode([
        'success' => false,
        'pesan' => 'Failed to update barang: ' . mysqli_error($conn)
    ]);
    exit;
}

$query = "INSERT INTO peminjaman (id_barang, kode_brg, id_peminjam, jml_brg, keperluan, status, tgl_pinjam, id_login) VALUES ('$id_barang', '$kode_barang', '$login', '$jumlah', '$keperluan', 'Dipinjam', NOW(), '$login')";
$data = mysqli_query($conn, $query);

if (!$data) {
    echo json_encode([
        'success' => false,
        'pesan' => 'Failed to insert peminjaman: ' . mysqli_error($conn)
    ]);
    exit;
}

echo json_encode([
    'success' => true,
    'pesan' => 'Sukses'
]);
?>
