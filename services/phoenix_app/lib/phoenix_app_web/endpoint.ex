defmodule PhoenixAppWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :phoenix_app

  @session_options [
    store: :cookie,
    key: "_phoenix_app_key",
    signing_salt: "phxSalt"
  ]

  plug Plug.Static,
    at: "/",
    from: :phoenix_app,
    gzip: false,
    only: ~w(robots.txt)

  if code_reloading? do
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug PhoenixAppWeb.Router
end
