defmodule PhoenixApp.Application do
  @moduledoc """
  Application supervisor tree for the PhoenixApp service.
  """
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhoenixApp.Repo,
      {Phoenix.PubSub, name: PhoenixApp.PubSub},
      PhoenixAppWeb.Endpoint
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: PhoenixApp.Supervisor)
  end

  @impl true
  def config_change(changed, _new, removed) do
    PhoenixAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
