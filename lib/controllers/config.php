<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "u430985337_digitalksp";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
