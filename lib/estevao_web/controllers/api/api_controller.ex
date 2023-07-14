defmodule EstevaoWeb.ApiController do
  use EstevaoWeb, :controller

  @app Mix.Project.config()[:app]
  @version Mix.Project.config()[:version]
  @description Mix.Project.config()[:description]

  def index(conn, _params) do
    json(conn, %{app: @app, version: @version, description: @description})
  end
end
