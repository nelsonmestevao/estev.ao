defmodule Estevao.Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "messages" do
    field :room_id, :string
    field :username, :string
    field :content, :string

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:content, :username, :room_id])
    |> validate_required([:content, :username, :room_id])
    |> validate_length(:content, min: 1, max: 3000)
  end
end
