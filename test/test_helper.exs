config =
  Testcontainers.PostgresContainer.new()
  |> Testcontainers.PostgresContainer.with_image("postgres:17")

{:ok, _postgres_container} = Testcontainers.start_container(config)

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Estevao.Repo, :manual)
