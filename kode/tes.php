function searchdata($table, $search) {
    global $koneksi;
    $search_param = "%" . $search . "%";
    $sql = "SELECT * FROM `$table` WHERE kode_barang LIKE ? OR nama_barang LIKE ? OR kategori LIKE ? OR merk LIKE ?";
    $stmt = $koneksi->prepare($sql);

    if (!$stmt) {
        die("Error in preparing the statement: " . $koneksi->error);
    }

    $stmt->bind_param("ssss", $search_param, $search_param, $search_param, $search_param);
    $stmt->execute();
    $result = $stmt->get_result();

    if (!$result) {
        die("Error in executing the query: " . $stmt->error);
    }

    return $result->fetch_all(MYSQLI_ASSOC);
}
