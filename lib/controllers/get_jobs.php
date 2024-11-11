<?php
include '../admin/connection.php';

header("Content-Type: application/json");

$response = [
    'status' => 'success',
    'data' => []
];


$query = "SELECT * FROM jobs";
$result = $conn->query($query);
$jobs = [];

while ($job = $result->fetch_assoc()) {
    $jobs[] = $job;
}

$response['data']['jobs'] = $jobs;
echo json_encode($response);
