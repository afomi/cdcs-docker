defmodule PhoenixAppWeb.ErrorJSON do
  @moduledoc false

  def render("404.json", _assigns) do
    %{errors: %{detail: "Not Found"}}
  end

  def render("500.json", _assigns) do
    %{errors: %{detail: "Server Error"}}
  end

  def render(_template, assigns) do
    %{errors: Map.get(assigns, :errors, %{detail: "Unknown error"})}
  end
end
