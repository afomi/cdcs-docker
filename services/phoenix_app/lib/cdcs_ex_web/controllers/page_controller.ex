defmodule CdcsExWeb.PageController do
  use CdcsExWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
