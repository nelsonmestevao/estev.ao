defmodule Estevao.Repo do
  use Ecto.Repo,
    otp_app: :estevao,
    adapter: Ecto.Adapters.Postgres
end
