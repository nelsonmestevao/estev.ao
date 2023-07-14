defmodule EstevaoWeb.LinkLive.Index do
  @moduledoc false
  use EstevaoWeb, :live_view

  alias Estevao.Shortner
  alias Estevao.Shortner.Link

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :links, Shortner.list_links())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Link")
    |> assign(:link, Shortner.get_link!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Link")
    |> assign(:link, %Link{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Links")
    |> assign(:link, nil)
  end

  @impl true
  def handle_info({EstevaoWeb.LinkLive.FormComponent, {:saved, link}}, socket) do
    {:noreply, stream_insert(socket, :links, link)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    link = Shortner.get_link!(id)
    {:ok, _} = Shortner.delete_link(link)

    {:noreply, stream_delete(socket, :links, link)}
  end
end
