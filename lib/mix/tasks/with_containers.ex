defmodule Mix.Tasks.WithContainers do
  @shortdoc "Runs a task with docker containers"

  @postgres_image "postgres:17"

  @moduledoc """
  Runs a Mix task with Docker containers managed by Testcontainers.

  ## Usage

      $ mix with_containers TASK [ARGS...]

  ## Example

      $ mix with_containers phx.server # you will need to "run migrations from the UI"

  ## Configuration

  The PostgreSQL image defaults to `#{@postgres_image}`.
  """
  use Mix.Task

  alias Testcontainers.PostgresContainer

  def run([sub_task | sub_task_args]) do
    Enum.each([:tesla, :hackney, :fs, :logger], fn app ->
      {:ok, _} = Application.ensure_all_started(app)
    end)

    {:ok, _} = ensure_started(Testcontainers)

    start_postgres_container()

    :ok = Mix.Task.run(sub_task, sub_task_args)

    Mix.Task.reenable("with_containers")
  end

  defp ensure_started(module) do
    case module.start() do
      {:ok, pid} -> {:ok, pid}
      {:error, {:already_started, pid}} -> {:ok, pid}
    end
  end

  defp start_postgres_container do
    {:ok, container} =
      PostgresContainer.new()
      |> PostgresContainer.with_image(@postgres_image)
      |> PostgresContainer.with_reuse(true)
      |> Testcontainers.start_container()

    params = container |> PostgresContainer.connection_parameters() |> Map.new()

    System.put_env(
      "DATABASE_URL",
      "ecto://#{params.username}:#{params.password}@#{params.hostname}:#{params.port}/#{params.database}"
    )
  end
end
