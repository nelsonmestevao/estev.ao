defmodule Estevao.ChatFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Estevao.Chat` context.
  """

  @doc """
  Generate a message.
  """
  def message_fixture(attrs \\ %{}) do
    {:ok, message} =
      attrs
      |> Enum.into(%{
        content: "some content",
        room: "some room",
        username: "some username"
      })
      |> Estevao.Chat.create_message()

    message
  end
end
