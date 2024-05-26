<?php
header("Access-Control-Allow-Origin: *");
$conn = mysqli_connect("localhost","root","","sas");
$query = mysqli_query($conn,"SELECT * FROM user");
$data = mysqli_fetch_all($query,MYSQLI_ASSOC);
echo json_encode($data);
?>