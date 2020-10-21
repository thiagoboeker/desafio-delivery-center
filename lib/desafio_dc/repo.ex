defmodule DesafioDc.Repo do
  use Ecto.Repo,
    otp_app: :desafio_dc,
    adapter: Ecto.Adapters.Postgres
end
