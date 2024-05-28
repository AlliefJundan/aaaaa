<?php
header("Access-Control-Allow-Origin: *");


$conn = mysqli_connect("localhost", "root", "", "sas");

$id = $_POST['id_barang'];

$query = "delete from barang where id_barang='$id'";
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
