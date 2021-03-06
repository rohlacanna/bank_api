# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :bank_api,
  ecto_repos: [BankApi.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :bank_api, BankApiWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: BankApiWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: BankApi.PubSub,
  live_view: [signing_salt: "pJxdCtkP"]

config :bank_api, BankApiWeb.UserAuth.Guardian,
  issuer: "bank_api",
  secret_key: "hWcVKM+HdF/wcV7zX2Otznt5JCX+SWNM2J9yNfpA6xexbT500SHgAXu18Tq01vlK"

config :guardian, Guardian.DB,
  repo: BankApi.Repo,
  schema_name: "guardian_tokens",
  sweep_interval: 60

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :bank_api, BankApi.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.0",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
