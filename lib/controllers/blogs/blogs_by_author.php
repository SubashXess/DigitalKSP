<?php
include '../../admin/connection.php';

header("Content-Type: application/json");

$response = [
    'status' => 'success',
    'data' => []
];

// Define your base URL here
// $base_url = "https://yourwebsite.com/";

// $protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] != 'off' || $_SERVER['SERVER_PORT'] == 443) ? "https://" : "http://";
// $base_url = $protocol . $_SERVER['HTTP_HOST'] . dirname($_SERVER['SCRIPT_NAME'], 3) . '/';


$author_id = isset($_GET['author']) ? $_GET['author'] : null;

if ($author_id === null) {
    $response['status'] = 'error';
    $response['message'] = 'Author ID is required';
    echo json_encode($response);
    exit;
}

$query = "SELECT * FROM blogs WHERE author = ?";
$stmt = $conn->prepare($query);
$stmt->bind_param("i", $author_id);

$stmt->execute();
$result = $stmt->get_result();


if ($result->num_rows > 0) {

    while ($row = $result->fetch_assoc()) {
        $response['data'][] = [
            'id' => $row['id'],
            'title' => $row['title'],
            'cover_photo' => $row['cover_photo'],
            // 'cover_photo' => $base_url . ltrim($row['cover_photo'], './'),
            'cover_tag' => $row['cover_tag'],
            'category' => $row['category'],
            'content' => $row['content'],
            'author' => $row['author'],
            'publish_date' => $row['publish_date'],
            'blog_description' => $row['blog_description'],
            'status' => $row['status'],
            'share_count' => $row['share_count'],
            // Add any other fields you need
        ];
    }
} else {
    $response['status'] = 'error';
    $response['message'] = 'No blogs found for this author';
}

$stmt->close();
$conn->close();

echo json_encode($response);
