<?php
$conn = mysqli_connect("localhost", "root", "", "sas");


    $kode = $_POST['kode_barang'];
    $nama = $_POST['nama_barang'];
    $merk = $_POST['merk_barang'];
    $jenis = $_POST['jenis_barang'];
    $jumlah = $_POST['jumlah_barang'];
    $peminjam = $_POST['id_peminjam'];
    $keperluan = $_POST['keperluan'];
    $jumlahPinjam = $_POST['jml_brg'];

    $data = "INSERT INTO peminjaman (tgl_pinjam, id_peminjam, kode_brg, jml_brg, keperluan, status, id_login)
              VALUES (NOW(), '$peminjam', '$kode', '$jumlahPinjam', '$keperluan', 'Dipinjam', '$peminjam')";

    if ($data) {
echo json_encode([
'pesan' => 'Sukses']);
}else {
echo json_encode([
'pesan' => 'Gagal']);
}
?>
