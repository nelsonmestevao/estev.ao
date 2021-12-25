defmodule EstevaoWeb.ChatLive.Show do
  use EstevaoWeb, :live_view

  alias Estevao.Chat
  alias Estevao.Chat.Message

  @impl true
  def mount(%{"room_id" => room_id}, _session, socket) do
    if connected?(socket), do: EstevaoWeb.Endpoint.subscribe(room_id)
    changeset = Chat.change_message(%Message{room: room_id})
    messages = Chat.list_messages()

    {:ok, assign(socket, room_id: room_id, changeset: changeset, messages: messages, temporary_assigns: [messages: []])}
  end

  @impl true
  def handle_event("validate", %{"message" => message_params}, socket) do
    changeset =
      %Message{}
      |> Chat.change_message(message_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, changeset: changeset)}
  end

  @impl true
  def handle_event("send", %{"message" => message_params}, socket) do
    case Chat.create_message(message_params) do
      {:ok, %Message{} = message} ->
        EstevaoWeb.Endpoint.broadcast!(socket.assigns.room_id, "new-message", message)

        {:noreply,
         socket
         |> assign(changeset: Chat.change_message(%Message{}))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_info("new-message", message, socket) do
    {:noreply, assign(socket, messages: [message])}
  end
end
