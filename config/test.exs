import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :estevao, Estevao.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "estevao_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

config :estevao, :basic_auth,
  username: "test",
  password: "test"

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :estevao, EstevaoWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "xq9MH8bk12efFS0Clw1RD+2sXfWKu3lVTSRrX3ZdQtEWs2HaxRxuvGjFESIIBNHl",
  server: false

# In test we don't send emails.
config :estevao, Estevao.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
