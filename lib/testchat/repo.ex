defmodule Testchat.Repo do
  use Ecto.Repo,
    otp_app: :testchat,
    adapter: Ecto.Adapters.Postgres
end
