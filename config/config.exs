# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :myexpenses_phx,
  ecto_repos: [MyexpensesPhx.Repo]

# Configures the endpoint
config :myexpenses_phx, MyexpensesPhxWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "IFkj6xcEh+/6B0FuI3xMYY+TTVdJAdunXraa62Szjh/PpPmDxwx3oQ+V7GSZnOiW",
  render_errors: [view: MyexpensesPhxWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MyexpensesPhx.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Poison for JSON parsing in Phoenix
config :phoenix, :json_library, Poison

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :ueberauth, Ueberauth,
  providers: [
    auth0: { Ueberauth.Strategy.Auth0, [] },
  ]

config :ueberauth, Ueberauth.Strategy.Auth0.OAuth,
  domain: System.get_env("AUTH0_DOMAIN"),
  client_id: System.get_env("AUTH0_CLIENT_ID"),
  client_secret: System.get_env("AUTH0_CLIENT_SECRET")