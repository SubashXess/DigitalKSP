<?php
include '../admin/connection.php';

// Number of profiles per page
$profilesPerPage = isset($_GET['limit']) ? (int)$_GET['limit'] : 8;

// Get current page number from the URL, default to 1 if not set
$page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
$offset = ($page - 1) * $profilesPerPage;

$response = [];

// Query to fetch individual profiles
$individualQuery = "SELECT id, full_name, designation, email, mobile, experience_years, bio, profile_photo 
                    FROM profiles 
                    WHERE profiles_status='Approved' 
                    LIMIT $profilesPerPage OFFSET $offset";
$individualResult = $conn->query($individualQuery);

// Add individual profiles to the response
$individualProfiles = [];
if ($individualResult->num_rows > 0) {
    while ($row = $individualResult->fetch_assoc()) {
        $individualProfiles[] = [
            'id' => $row['id'],
            'name' => $row['full_name'],
            'designation' => $row['designation'],
            'email' => $row['email'],
            'mobile' => $row['mobile'],
            'experience_years' => $row['experience_years'],
            'bio' => $row['bio'],
            'profile_photo' => $row['profile_photo']
        ];
    }
}

// Query to fetch organization profiles
$orgQuery = "SELECT id, org_name, org_mobile, org_email, service_years, bio, est_date, profile_photo 
             FROM org_profiles 
             WHERE profiles_status='Approved' 
             LIMIT $profilesPerPage OFFSET $offset";
$orgResult = $conn->query($orgQuery);

// Add organization profiles to the response
$orgProfiles = [];
if ($orgResult->num_rows > 0) {
    while ($row = $orgResult->fetch_assoc()) {
        $orgProfiles[] = [
            'id' => $row['id'],
            'org_name' => $row['org_name'],
            'org_email' => $row['org_email'],
            'org_mobile' => $row['org_mobile'],
            'service_years' => $row['service_years'],
            'bio' => $row['bio'],
            'est_date' => $row['est_date'],
            'profile_photo' => $row['profile_photo']
        ];
    }
}

// Total profiles for pagination
$totalIndividualQuery = "SELECT COUNT(*) AS total FROM profiles WHERE profiles_status='Approved'";
$totalOrgQuery = "SELECT COUNT(*) AS total FROM org_profiles WHERE profiles_status='Approved'";
$totalIndividual = $conn->query($totalIndividualQuery)->fetch_assoc()['total'];
$totalOrg = $conn->query($totalOrgQuery)->fetch_assoc()['total'];

// Calculate total pages
$totalProfiles = $totalIndividual + $totalOrg;
$totalPages = ceil($totalProfiles / $profilesPerPage);

// Response structure
$response = [
    'total_profiles' => $totalProfiles,
    'total_pages' => $totalPages,
    'current_page' => $page,
    'profiles_per_page' => $profilesPerPage,
    'individual_profiles' => $individualProfiles,
    'organization_profiles' => $orgProfiles
];

// Set header and return JSON response
header('Content-Type: application/json');
echo json_encode($response);
