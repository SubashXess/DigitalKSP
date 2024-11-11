<?php
include '../admin/connection.php';

header("Content-Type: application/json");

$response = [
    'status' => 'success',
    'data' => []
];


$query = "SELECT * FROM profiles";
$result = $conn->query($query);
$wish_wall_profiles = [];

while ($wish_wall_profile = $result->fetch_assoc()) {
    $wish_wall_profiles[] = $wish_wall_profile;
}

$response['data']['wish_wall_profile'] = $wish_wall_profiles;
echo json_encode($response);
