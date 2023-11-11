use serde::Serialize;
use warp::{reply::json, Filter, Rejection, Reply};
use gethostname::gethostname;
use uuid::Uuid;
use std::env;

fn get_env_as_int(key: &str, default: u16) -> u16 {
    match env::var(key) {
        Ok(value) => value.parse().unwrap_or(default),
        Err(_) => default,
    }
}

type WebResult<T> = std::result::Result<T, Rejection>;


#[derive(Serialize)]
pub struct PayloadResponse {
    language: String,
    hostname: String,
    timestamp: String,
    uuid: String,
}

#[derive(Serialize)]
struct Health {
    status: String,
}


pub async fn payload_handler() -> WebResult<impl Reply> {
    let response_json = &PayloadResponse {
        language: "rust".to_string(),
        hostname: gethostname().to_string_lossy().to_string(),
        timestamp: chrono::Utc::now().to_rfc3339(),
        uuid : Uuid::new_v4().to_string(),
    };
    Ok(json(response_json))
}

pub async fn health_handler() -> WebResult<impl Reply> {
    let response_json = &Health {
        status: "ok".to_string(),
    };
    Ok(json(response_json))
}


#[tokio::main]
async fn main() {
    env::set_var("RUST_LOG", "api=info");
    pretty_env_logger::init();

    let port = get_env_as_int("PORT", 8095);

    let payload = warp::path!("api")
        .and(warp::get())
        .and_then(payload_handler);

    let health = warp::path!("health")
        .and(warp::get())
        .and_then(health_handler);

    let routes =  warp::get().and(payload.or(health)).with(warp::log("api"));

    println!("🚀 Server started successfully");
    warp::serve(routes).run(([0, 0, 0, 0], port)).await;
}
