use axum::{response::Html, routing::get, Router};
use tower_service::Service;
use worker::*;

fn router() -> Router {
	Router::new()
		.route("/", get(root))
		.route("/test", get(test))
}

#[event(fetch)]
async fn fetch(
	req: HttpRequest,
	_env: Env,
	_ctx: Context,
) -> Result<axum::http::Response<axum::body::Body>> {
	console_error_panic_hook::set_once();

	Ok(router().call(req).await?)
}

pub async fn root() -> Html<&'static str> {
	Html("<h1>Yo!</h1><p>I am a Cloudflare worker using Rust!</p><p>Check out my routing:</p><ul><li><a href='/test'>Routing action go!</a></li></ul>")
}

pub async fn test() -> Html<&'static str> {
	Html("<p>I am a test page</p><ul><li><a href='/'>Take me home</a></li></ul>")
}
