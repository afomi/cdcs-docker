defmodule CdcsEx.Repo do
  use Ecto.Repo,
    otp_app: :cdcs_ex,
    adapter: Ecto.Adapters.Postgres
end
