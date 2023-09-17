<?php

$routes = [
	'/' => 'mainPayload',
    '/health' => 'healthCheck',
];

function mainPayload() {
    $data = [
        "language" => "php",
        "hostname" => gethostname(),
        "timestamp" => time(),
        "uuid" => uniqid(),
    ];
    echo json_encode($data);
}

function healthCheck() {
	echo json_encode(['status' => 'OK']);
}

$request_uri = $_SERVER['REQUEST_URI'];
$request_uri = strtok($request_uri, '?');

if (array_key_exists($request_uri, $routes)) {
	header('Content-Type: application/json; charset=utf-8');
    $routeFunction = $routes[$request_uri];
    $routeFunction();
} else {
    http_response_code(404);
    echo "404 - Page not found";
}
