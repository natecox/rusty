use worker::*;

#[event(fetch)]
async fn main(_req: Request, _env: Env, _ctx: Context) -> Result<Response> {
	Response::from_html("<h1>Yo!</h1><p>I'm a Cloudflare worker.</p><p>I'm running on Rust!</p>")
}
