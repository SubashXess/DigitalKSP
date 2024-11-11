<?php
include '../admin/connection.php';

header("Content-Type: application/json");

$response = [
    'status' => 'success',
    'data' => []
];

$query = "SELECT * FROM author";
$result = $conn->query($query);
$authors = [];

while ($author = $result->fetch_assoc()) {
    $authors[] = $author;
}

$response['data']['authors'] = $authors;
echo json_encode($response);
