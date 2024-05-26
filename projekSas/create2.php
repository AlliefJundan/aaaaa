<?php
$conn = mysqli_connect("localhost", "root", "", "sas");

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $nama = $_POST['nama_barang'];
    $merk = $_POST['merk_barang'];
    $jenis = $_POST['jenis_barang'];
    $jumlah = $_POST['jumlah_barang'];

    $query = "INSERT INTO barang (nama_barang, merk_barang, jenis_barang, jumlah_barang)
              VALUES ('$nama', '$merk', '$jenis', '$jumlah')";

    if (mysqli_query($conn, $query)) {
        echo json_encode([
            'success' => true,
            'pesan' => 'Sukses'
        ]);
    } else {
        echo json_encode([
            'success' => false,
            'pesan' => 'Gagal'
        ]);
    }
} else {
    echo json_encode([
        'success' => false,
        'pesan' => 'Invalid request method'
    ]);
}

mysqli_close($conn);
?>
