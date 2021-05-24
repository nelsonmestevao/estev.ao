defmodule EstevaoWeb.PageLive do
  use EstevaoWeb, :live_view

  alias Estevao.Shortner
  alias Estevao.Shortner.Link

  @impl true
  def mount(_params, _session, socket) do
    changeset = Shortner.change_link(%Link{})

    {:ok, assign(socket, changeset: changeset, result: nil)}
  end

  @impl true
  def handle_event("validate", %{"link" => link_params}, socket) do
    changeset =
      %Link{}
      |> Shortner.change_link(link_params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  @impl true
  def handle_event("create", %{"link" => link_params}, socket) do
    case Shortner.create_link(link_params) do
      {:ok, %Link{} = link} ->
        {:noreply,
         socket
         |> assign(changeset: Shortner.change_link(%Link{}))
         |> assign(result: Map.put(link, :link, "#{EstevaoWeb.Endpoint.url()}/r/#{link.slug}"))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
