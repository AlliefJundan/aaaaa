<?php
header("Access-Control-Allow-Origin: *");
$conn = mysqli_connect("localhost","root","","sas");
$query = mysqli_query($conn,"SELECT peminjaman.id_peminjaman, peminjaman.tgl_pinjam, peminjaman.tgl_kembali, peminjaman.id_peminjam, barang.kode_barang, barang.nama_barang, peminjaman.jml_brg, peminjaman.keperluan, peminjaman.status, peminjaman.id_login FROM peminjaman INNER JOIN barang on peminjaman.kode_brg = barang.kode_barang ORDER BY id_peminjaman ASC");
$data = mysqli_fetch_all($query,MYSQLI_ASSOC);
echo json_encode($data);
?>