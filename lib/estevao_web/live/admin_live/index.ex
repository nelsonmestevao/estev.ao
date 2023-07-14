defmodule EstevaoWeb.AdminLive.Index do
  use EstevaoWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(_params, _url, socket) do
    {:noreply, assign(socket, :page_title, "Admin")}
  end
end
