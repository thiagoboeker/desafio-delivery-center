# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :desafio_dc,
  ecto_repos: [DesafioDc.Repo]

# Configures the endpoint
config :desafio_dc, DesafioDcWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "vlgTYfjs6T8VzsyjzeZAom+zoI1udqrBf5Os5fbtm6VMxJXB97FUMQ/tFN3we5AP",
  render_errors: [view: DesafioDcWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: DesafioDc.PubSub,
  live_view: [signing_salt: "kxsavxW/"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
