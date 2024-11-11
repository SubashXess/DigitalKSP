<?php
include '../admin/connection.php';

header("Content-Type: application/json");

$response = [
    'status' => 'success',
    'data' => []
];


$query = "SELECT * FROM blog_content";
$result = $conn->query($query);
$blog_contents = [];

while ($blog_content = $result->fetch_assoc()) {
    $blog_contents[] = $blog_content;
}

$response['data']['blog_contents'] = $blog_contents;
echo json_encode($response);
