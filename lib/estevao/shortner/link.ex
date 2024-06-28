defmodule Estevao.Shortner.Link do
  @moduledoc """
  A Link in the application.
  """
  use Estevao, :schema

  import Estevao.Utils.Datafiles

  @type slug :: String.t()

  @slug_alphabet "123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ"

  schema "links" do
    field :url, :string
    field :slug, :string, autogenerate: {Nanoid, :generate, [6, @slug_alphabet]}
    field :visits, :integer, default: 0

    timestamps()
  end

  @reserved_names Enum.concat([
                    read_data_file!("databases.txt"),
                    read_data_file!("general.txt"),
                    read_data_file!("libraries.txt"),
                    read_data_file!("notes.txt"),
                    read_data_file!("programming_languages.txt"),
                    read_data_file!("tools.txt")
                  ])

  @required_fields [:url]
  @optional_fields [:slug]
  @doc false
  def create_changeset(link, attrs) do
    link
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_url(:url, "invalid URL")
    |> validate_exclusion(:slug, @reserved_names)
    |> unique_constraint(:slug)
  end

  @optional_fields [:slug, :visits]
  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_url(:url, "invalid URL")
    |> unique_constraint(:slug)
  end
end
