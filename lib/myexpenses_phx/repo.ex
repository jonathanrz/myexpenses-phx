defmodule MyexpensesPhx.Repo do
  use Ecto.Repo,
    otp_app: :myexpenses_phx,
    adapter: Ecto.Adapters.Postgres
end
