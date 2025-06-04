defmodule EstevaoWeb.HealthCheckPlug do
  @moduledoc false

  @behaviour Plug

  import Plug.Conn

  @app Mix.Project.config()[:app]
  @description Mix.Project.config()[:description]

  @impl true
  def init(opts), do: opts

  @impl true
  def call(%Plug.Conn{request_path: "/health"} = conn, _opts) do
    conn
    |> put_resp_header("access-control-allow-origin", "*")
    |> put_resp_content_type("plain/text")
    |> send_resp(200, "OK")
    |> halt()
  end

  @impl true
  def call(%Plug.Conn{request_path: "/_version"} = conn, _opts) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, Estevao.version())
    |> halt()
  end

  @content Jason.encode!(%{app: @app, description: @description})
  @impl true
  def call(%Plug.Conn{request_path: "/_about.json"} = conn, _opts) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, @content)
    |> halt()
  end

  @impl true
  def call(conn, _opts), do: conn
end
