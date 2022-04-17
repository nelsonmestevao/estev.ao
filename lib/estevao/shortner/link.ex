defmodule Estevao.Shortner.Link do
  use Estevao.Schema

  @url_regex ~r/https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()!@:%_\+.~#?&\/\/=]*)/
  @slug_alphabet "123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ"

  schema "links" do
    field :slug, :string
    field :url, :string
    field :visits, :integer, default: 0

    timestamps()
  end

  @required_fields [:url]
  @optional_fields [:slug]
  @doc false
  def create_changeset(link, attrs) do
    link
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_format(:url, @url_regex)
    |> generate_slug()
    |> unique_constraint(:slug)
  end

  @optional_fields [:slug, :visits]
  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_format(:url, @url_regex)
    |> unique_constraint(:slug)
  end

  defp generate_slug(%Ecto.Changeset{valid?: true, changes: changes} = changeset)
       when not is_map_key(changes, :slug) do
    changeset
    |> change(slug: Nanoid.generate(6, @slug_alphabet))
  end

  defp generate_slug(changeset), do: changeset
end
