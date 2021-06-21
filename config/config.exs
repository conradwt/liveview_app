# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :liveview_app,
  ecto_repos: [LiveviewApp.Repo]

# Configures the endpoint
config :liveview_app, LiveviewAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "xgHWMkNteaFVUCsOiSPMnW2Ebmi0G8RxNtDdx2bR6s4XBflhxGEvBhrd0qXRKAsC",
  render_errors: [view: LiveviewAppWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: LiveviewApp.PubSub,
  live_view: [signing_salt: "api7+8FC"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
