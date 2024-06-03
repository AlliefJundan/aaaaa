<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

$conn = mysqli_connect("localhost", "root", "", "sas");

if ($_SERVER['REQUEST_METHOD'] == "POST") {
    $response = array();
    $username = $_POST['username'];
    $password = $_POST['password'];

    $query = "SELECT id_user, role FROM user WHERE username='$username' AND password='$password'";
    $result = mysqli_query($conn, $query);

    if ($result && mysqli_num_rows($result) > 0) {
        $row = mysqli_fetch_assoc($result);
        $response['value'] = 1;
        $response['message'] = "Login Berhasil";
        $response['id_user'] = $row['id_user'];
        $response['role'] = $row['role']; // Pastikan role dikembalikan di response
    } else {
        $response['value'] = 0;
        $response['message'] = "Username Atau Password Salah";
    }
    echo json_encode($response);
}
?>
