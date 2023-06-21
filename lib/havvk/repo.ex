defmodule Havvk.Repo do
  use Ecto.Repo,
    otp_app: :havvk,
    adapter: Ecto.Adapters.Postgres
end
