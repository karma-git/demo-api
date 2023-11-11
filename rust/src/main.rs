use serde::Serialize;
use warp::{reply::json, Filter, Rejection, Reply};
use gethostname::gethostname;
use uuid::Uuid;


type WebResult<T> = std::result::Result<T, Rejection>;


#[derive(Serialize)]
pub struct PayloadResponse {
    language: String,
    hostname: String,
    timestamp: String,
    uuid: String,
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

#[tokio::main]
async fn main() {
    if std::env::var_os("RUST_LOG").is_none() {
        std::env::set_var("RUST_LOG", "api=info");
    }
    pretty_env_logger::init();

    // let health_checker = warp::path!("api" / "healthchecker")
    let payload = warp::path!("api" / "root")
        .and(warp::get())
        .and_then(payload_handler);

    let routes = payload.with(warp::log("api"));

    println!("🚀 Server started successfully");
    warp::serve(routes).run(([0, 0, 0, 0], 8095)).await;
}
