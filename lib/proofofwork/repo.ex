defmodule Proofofwork.Repo do
  use Ecto.Repo,
    otp_app: :proofofwork,
    adapter: Ecto.Adapters.Postgres
end
