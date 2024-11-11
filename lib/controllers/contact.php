<?php
include '../admin/connection.php';

header("Content-Type: application/json");

$response = [
    'status' => 'success',
    'message' => 'Your form has been submitted'
];

$input = json_decode(file_get_contents("php://input"), true);

// Retrieve and validate POST data
$name = isset($input['name']) ? $input['name'] : '';
$city = isset($input['city']) ? $input['city'] : '';
$mobile = isset($input['mobile']) ? $input['mobile'] : '';
$email = isset($input['email']) ? $input['email'] : '';

if ($name && $city && $mobile && $email) {

    // Prepare the SQL query with placeholders
    $query = "INSERT INTO contact (name, city, mobile, email) VALUES (?, ?, ?, ?)";

    // Prepare the statement
    $stmt = $conn->prepare($query);

    // Bind parameters (all as strings, 'ssss' represents four string parameters)
    $stmt->bind_param("ssss", $name, $city, $mobile, $email);

    // Execute the query and check for success
    if ($stmt->execute()) {
        $response['status'] = 'success';
        $response['message'] = 'Your form has been submitted successfully.';
        
    } else {
        $response['status'] = 'error';
        $response['message'] = 'Failed to submit the form. Please try again.';
    }

    // Close the statement
    $stmt->close();
} else {
    $response['status'] = 'error';
    $response['message'] = 'All fields are required.';
}

// Output the JSON response
echo json_encode($response);

// Close the database connection
$conn->close();
