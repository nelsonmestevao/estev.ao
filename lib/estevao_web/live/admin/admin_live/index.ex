defmodule EstevaoWeb.AdminLive.Index do
  @moduledoc false
  use EstevaoWeb, :live_view

  @name Mix.Project.config()[:name]
  @version Mix.Project.config()[:version]
  @description Mix.Project.config()[:description]

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, name: @name, version: @version, description: @description)}
  end

  @impl true
  def handle_params(_params, _url, socket) do
    {:noreply, assign(socket, :page_title, "Admin")}
  end
end
