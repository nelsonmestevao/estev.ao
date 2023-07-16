defmodule EstevaoWeb.ApiController do
  use EstevaoWeb, :controller

  @app Mix.Project.config()[:app]
  @version Mix.Project.config()[:version]
  @description Mix.Project.config()[:description]
  @git_ref Mix.Project.config()[:git_ref]

  def index(conn, _params) do
    json(conn, %{app: @app, version: @version, description: @description})
  end

  def version(conn, _params) do
    text(conn, @git_ref)
  end
end
