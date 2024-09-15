defmodule EstevaoWeb.HomeLive.Index do
  @moduledoc false
  use EstevaoWeb, :live_view

  alias Estevao.Shortner.Handlers.Links
  alias Estevao.Shortner.Link

  @name Mix.Project.config()[:name]
  @description Mix.Project.config()[:description]

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(name: @name, description: @description)
     |> assign(result: nil)
     |> assign_form(Links.new_link()), layout: false}
  end

  @impl true
  def handle_event("validate", %{"link" => link_params}, socket) do
    changeset =
      %Link{}
      |> Links.change_link(link_params)
      |> Map.put(:action, :validate)

    socket
    |> assign_form(changeset)
    |> noreply()
  end

  @impl true
  def handle_event("create", %{"link" => link_params}, socket) do
    case Links.create_link(link_params) do
      {:ok, %Link{} = link} ->
        socket
        |> assign_form(Links.new_link())
        |> assign(result: Map.put(link, :link, "#{EstevaoWeb.Endpoint.url()}/#{link.slug}"))
        |> noreply()

      {:error, %Ecto.Changeset{} = changeset} ->
        socket
        |> assign_form(changeset)
        |> noreply()
    end
  end
end
