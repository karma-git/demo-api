use actix_web::{get, post, web, App, HttpResponse, HttpServer, Responder};
use std::collections::HashMap;

fn rust_response() -> HashMap{
    let mut rust_response = HashMap::new();
    rust_response.insert("language", vec!["rust"]);
    return rust_response;
}

#[get("/")]
async fn hello() -> impl Responder {
    HttpResponse::Ok().body("Hello")
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(|| {
        App::new()
            .service(hello)
    })
    .bind("127.0.0.1:8080")?
    .run()
    .await
}

// gethostname()
