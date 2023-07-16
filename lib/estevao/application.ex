defmodule Estevao.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      EstevaoWeb.Telemetry,
      # Start the Ecto repository
      Estevao.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Estevao.PubSub},
      # Start Finch
      {Finch, name: Estevao.Finch},
      # Start the Endpoint (http/https)
      EstevaoWeb.Endpoint,
      # Start a worker by calling: Estevao.Worker.start_link(arg)
      {Estevao.Shortner.Services.UpdateLinkVisits, []}
      # {Estevao.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Estevao.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    EstevaoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
