import Config

config :phoenix_app,
  ecto_repos: [PhoenixApp.Repo]

config :phoenix_app, PhoenixAppWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [formats: [json: PhoenixAppWeb.ErrorJSON], layout: false],
  pubsub_server: PhoenixApp.PubSub

config :phoenix, :json_library, Jason
