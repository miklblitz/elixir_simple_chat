use Mix.Config

# Configure your database
config :testchat, Testchat.Repo,
  username: "postgres",
  password: "111",
  database: "testchat_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :testchat, TestchatWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
