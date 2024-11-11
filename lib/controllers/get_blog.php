<?php
include '../admin/connection.php';

// Parameters for pagination
$blogsPerPage = isset($_GET['limit']) ? (int)$_GET['limit'] : 5;
$page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
$offset = ($page - 1) * $blogsPerPage;

// Prepare response array
$response = [];

// Query to fetch blog data
$blogQuery = "SELECT * FROM blogs WHERE status = 'Approved' LIMIT $blogsPerPage OFFSET $offset";

$blogResult = $conn->query($blogQuery);

$blogs = [];
if ($blogResult->num_rows > 0) {
    while ($row = $blogResult->fetch_assoc()) {
        $blogs[] = [
            'id' => $row['id'],
            'title' => $row['title'],
            'cover_photo' => $row['cover_photo'],
            'cover_tag' => $row['cover_tag'],
            'cover_title' => $row['cover_title'],
            'category' => $row['category'],
            'content' => $row['content'],
            'author' => $row['author'],
            'publish_date' => $row['publish_date'],
            'blog_description' => $row['blog_description'],
            'published_date' => $row['published_date'],
            'updated_date' => $row['updated_date'],
            'status' => $row['status'],
            'remark' => $row['remark'],
            'type' => $row['type'],
            'share_count' => $row['share_count'],
            'user_id' => $row['user_id']
        ];
    }
}

// Count total published blogs for pagination
$totalBlogsQuery = "SELECT COUNT(*) AS total FROM blogs WHERE status = 'Approved'";
$totalBlogsResult = $conn->query($totalBlogsQuery);
$totalBlogs = $totalBlogsResult->fetch_assoc()['total'];
$totalPages = ceil($totalBlogs / $blogsPerPage);

// Add pagination and blog data to response
$response = [
    'total_blogs' => $totalBlogs,
    'total_pages' => $totalPages,
    'current_page' => $page,
    'blogs_per_page' => $blogsPerPage,
    'blogs' => $blogs
];

// Set header to JSON and output the response
header('Content-Type: application/json');
echo json_encode($response);
