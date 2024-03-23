defmodule EstevaoWeb.HealthCheckPlug do
  @moduledoc false

  @behaviour Plug

  import Plug.Conn

  @app Mix.Project.config()[:app]
  @version Mix.Project.config()[:version]
  @description Mix.Project.config()[:description]
  @env Mix.env()
  @git_ref String.slice(Mix.Project.config()[:git_ref], 0, 8)

  @impl true
  def init(opts), do: opts

  @impl true
  def call(%Plug.Conn{request_path: "/health"} = conn, _opts) do
    conn
    |> send_resp(200, "OK")
    |> halt()
  end

  @content "#{@version}-#{@env}+#{@git_ref}"
  @impl true
  def call(%Plug.Conn{request_path: "/_version"} = conn, _opts) do
    conn
    |> send_resp(200, @content)
    |> halt()
  end

  @content Jason.encode!(%{
             app: @app,
             version: @version,
             description: @description,
             build: "#{@env}+#{@git_ref}"
           })
  @impl true
  def call(%Plug.Conn{request_path: "/_version.json"} = conn, _opts) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, @content)
    |> halt()
  end

  @impl true
  def call(conn, _opts), do: conn
end
