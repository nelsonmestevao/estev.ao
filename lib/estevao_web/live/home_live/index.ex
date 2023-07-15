defmodule EstevaoWeb.HomeLive.Index do
  @moduledoc false
  use EstevaoWeb, :live_view

  alias Estevao.Shortner.Link
  alias Estevao.Shortner.Services.ChangeLink
  alias Estevao.Shortner.Services.CreateLink

  @name Mix.Project.config()[:name]
  @description Mix.Project.config()[:description]

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(name: @name, description: @description)
     |> assign(result: nil)
     |> assign_form(new_link()), layout: false}
  end

  @impl true
  def handle_event("validate", %{"link" => link_params}, socket) do
    changeset =
      %Link{}
      |> ChangeLink.call(link_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  @impl true
  def handle_event("create", %{"link" => link_params}, socket) do
    case CreateLink.call(link_params) do
      {:ok, %Link{} = link} ->
        {:noreply,
         socket
         |> assign_form(new_link())
         |> assign(result: Map.put(link, :link, "#{EstevaoWeb.Endpoint.url()}/#{link.slug}"))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp new_link do
    ChangeLink.call(%Link{})
  end
end
