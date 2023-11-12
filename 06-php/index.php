<?php
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Factory\AppFactory;

const PORT = 8080;

require __DIR__ . '/vendor/autoload.php';

// Instantiate App
$app = AppFactory::create();
$port = getenv('PORT') ?: PORT;

// Add error middleware
$app->addErrorMiddleware(true, true, true);

// Add routes

$app->get('/', function (Request $request, Response $response) {
  $dateTime = new DateTime();

  $data = [
    "language" => "🐘 php",
    "hostname" => gethostname(),
    "timestamp" => $dateTime->format('Y-m-d\TH:i:s.u'),
    "uuid" => uniqid(),
  ];
  $payload = json_encode($data);
  $response->getBody()->write($payload);
  return $response
            ->withHeader('Content-Type', 'application/json');
});

$app->get('/health', function (Request $request, Response $response) {
  $data = [
    "status" => "ok",
  ];
  $payload = json_encode($data);
  $response->getBody()->write($payload);
  return $response
            ->withHeader('Content-Type', 'application/json');
});

$app->run();
