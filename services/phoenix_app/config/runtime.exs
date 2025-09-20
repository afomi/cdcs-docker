import Config

if config_env() == :prod do
  database_url =
    System.get_env("DATABASE_URL") ||
      raise "DATABASE_URL environment variable is missing. Example: ecto://USER:PASS@HOST:PORT/DB"

  ssl? =
    case System.get_env("ECTO_USE_SSL") do
      value when value in ["true", "1", "TRUE"] -> true
      _ -> false
    end

  pool_size =
    System.get_env("POOL_SIZE", "10")
    |> String.to_integer()

  config :phoenix_app, PhoenixApp.Repo,
    url: database_url,
    pool_size: pool_size,
    ssl: ssl?

  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise "SECRET_KEY_BASE environment variable is missing. You can generate one with mix phx.gen.secret"

  host = System.get_env("PHX_HOST", "localhost")
  port =
    System.get_env("PHX_PORT") ||
      System.get_env("PORT") ||
      "4000"
  port_int = String.to_integer(port)

  config :phoenix_app, PhoenixAppWeb.Endpoint,
    url: [host: host, port: port_int],
    http: [ip: {0, 0, 0, 0}, port: port_int],
    secret_key_base: secret_key_base,
    server: true
end
