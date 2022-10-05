defmodule EstevaoWeb.ChatLive.Show do
  use EstevaoWeb, :live_view

  alias Estevao.Chat
  alias Estevao.Chat.Message

  @impl true
  def mount(%{"room_id" => room_id}, _session, socket) do
    topic = "room:" <> room_id
    username = MnemonicSlugs.generate_slug(2)

    if connected?(socket) do
      EstevaoWeb.Endpoint.subscribe(topic)
      EstevaoWeb.Presence.track(self(), topic, username, %{})
    end

    changeset = Chat.change_message(%Message{})
    messages = Chat.list_messages(%{"room_id" => room_id})

    {:ok,
     assign(socket,
       changeset: changeset,
       room_id: room_id,
       username: username,
       topic: topic,
       online_users: [],
       messages: messages
     )}
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
    message_params =
      message_params
      |> Map.put("room_id", socket.assigns.room_id)
      |> Map.put("username", socket.assigns.username)

    case Chat.create_message(message_params) do
      {:ok, %Message{} = message} ->
        EstevaoWeb.Endpoint.broadcast!(socket.assigns.topic, "new-message", %{
          "message" => message
        })

        {:noreply,
         socket
         |> assign(changeset: Chat.change_message(%Message{}))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  @impl true
  def handle_info(%{event: "new-message", payload: %{"message" => message}}, socket) do
    {:noreply, assign(socket, messages: socket.assigns.messages ++ [message])}
  end

  @impl true
  def handle_info(%{event: "presence_diff", payload: %{joins: _joins, leaves: _leaves}}, socket) do
    online_users =
      EstevaoWeb.Presence.list(socket.assigns.topic)
      |> Map.keys()

    {:noreply, assign(socket, online_users: online_users)}
  end

  defp extract_initials(name) do
    initials = name |> String.upcase() |> String.split("-") |> Enum.map(&String.slice(&1, 0, 1))

    case length(initials) do
      1 -> hd(initials)
      _ -> List.first(initials) <> List.last(initials)
    end
  end
end
