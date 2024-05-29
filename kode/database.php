<?php
$host = "localhost";
$user = "root";
$pass = "";
$dbname = "sas";
$koneksi = mysqli_connect($host, $user, $pass, $dbname) or die("Gagal terhubung dengan database " . mysqli_error($koneksi));

function tampildata($tablename)
{
    global $koneksi;
    $hasil = mysqli_query($koneksi, "SELECT peminjaman.id_peminjaman, peminjaman.tgl_pinjam, peminjaman.tgl_kembali, peminjaman.id_peminjam, barang.id_barang, barang.kode_barang, barang.nama_barang, peminjaman.jml_brg, peminjaman.keperluan, peminjaman.status, peminjaman.id_login FROM peminjaman INNER JOIN barang on peminjaman.id_barang = barang.id_barang ORDER BY id_peminjaman ASC");
    $rows = [];
    while ($row = mysqli_fetch_assoc($hasil)) {
        $rows[] = $row;
    }
    return $rows;
}

function editdatabarang($tablename, $id)
{
    global $koneksi;
    $query = "SELECT * from $tablename where id_barang = $id";
    $hasil = $koneksi->query($query);

    if ($hasil->num_rows > 0) {
        return $hasil->fetch_assoc();
    } else {
        return null;
    }
}


function delete($tablename, $id)
{
    global $koneksi;
    $hasil = mysqli_query($koneksi, "DELETE from $tablename where id_barang='$id'");
    return $hasil;
}

function cek_login($username, $password)
{
    global $koneksi;
    $uname = $username;
    $upass = $password;

    $hasil = mysqli_query($koneksi, "select * from user where username='$uname' and password='$upass'");
    $cek = mysqli_num_rows($hasil);
    if ($cek > 0) {
        $query = mysqli_fetch_array($hasil);
        $_SESSION['id'] = $query['id'];
        $_SESSION['username'] = $query['username'];
        $_SESSION['role'] = $query['role'];
        return true;
    } else {
        return false;
    }
}

function tampildata1($tablename)
{
    global $koneksi;
    $hasil = mysqli_query($koneksi, "select * from $tablename");
    $rows = [];
    while ($row = mysqli_fetch_assoc($hasil)) {
        $rows[] = $row;
    }
    return $rows;
}


function tambahbarang($kode_brg, $nama_brg, $kategori, $merk, $jumlah)
{
    global $koneksi;
    $query = "INSERT INTO barang (kode_barang, nama_barang, jenis, merk, jumlah) VALUES ('$kode_brg', '$nama_brg', '$kategori', '$merk', $jumlah)";

    if ($koneksi->query($query) === TRUE) {
        return "Barang berhasil ditambahkan.";
    } else {
        return "Error: " . $query . "<br>" . $koneksi->error;
    }
}
function getAllBarang()
{
    global $koneksi;
    $sql = "SELECT kode_barang, nama_barang, merk, jenis, jumlah FROM barang";
    return $koneksi->query($sql);
}

function barang($id_barang)
{
    global $koneksi;
    $sql = "SELECT * FROM barang WHERE kode_barang = '$id_barang' OR jumlah";
    $result = $koneksi->query($sql);
    if ($result->num_rows > 0) {
        $barang = $result->fetch_assoc();
        return $barang;
    } else {
        return array("error" => "Barang tidak ditemukan atau stok habis");
    }
}


function kembali($tablename, $id) {
    global $koneksi;
    // Example update assuming you want to set `status` to 'returned'
    $hasil = mysqli_query($koneksi, "UPDATE $tablename SET status = 'Kembali' WHERE id_peminjaman = '$id'");
    return $hasil;
}

function populer($tablename)
{
    global $koneksi;
    $sql = mysqli_query($koneksi, "SELECT peminjaman.kode_brg, barang.nama_barang, SUM(peminjaman.jml_brg) AS total_dipinjam
    FROM peminjaman
    JOIN barang ON peminjaman.kode_barang = barang.kode_brg
    GROUP BY peminjaman.kode_barang, barang.nama_brg
    ORDER BY total_dipinjam DESC
    LIMIT 5;
    ");
    $rows = [];
    while ($row = mysqli_fetch_assoc($sql)) {
        $rows[] = $row;
    }
    return $rows;
}
?>