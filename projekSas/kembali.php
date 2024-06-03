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

$id_peminjaman = $_POST['id_peminjaman'];
$id_barang = $_POST['id_barang'];
$jumlah = $_POST['jml_brg'];

$tambah = "UPDATE barang SET jumlah = jumlah + '$jumlah' WHERE id_barang = '$id_barang'";
$tambah_result = mysqli_query($conn, $tambah);

if (!$tambah_result) {
    echo json_encode([
        'success' => false,
        'pesan' => 'Failed to update barang: ' . mysqli_error($conn)
    ]);
    exit;
}

$query = "UPDATE peminjaman set `status` = 'Kembali', `tgl_kembali` = NOW() WHERE `id_peminjaman` = '$id_peminjaman'";
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
