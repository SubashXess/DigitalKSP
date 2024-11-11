<?php
include '../admin/connection.php';

header("Content-Type: application/json");

$response = [
    'status' => 'success',
    'data' => []
];

$category_query = "SELECT blogs.category AS category_name, COUNT(*) AS blog_count FROM blogs WHERE status = 'Approved' GROUP BY blogs.category";
$category_result = $conn->query($category_query);
$categories = [];

while ($category = $category_result->fetch_assoc()) {
    $categories[] = $category;
}

$response['data']['categories'] = $categories;

echo json_encode($response);
