defmodule PhoenixAppWeb.PageController do
  use PhoenixAppWeb, :controller

  def index(conn, _params) do
    text(conn, "Phoenix 1.8 app is running")
  end
end
