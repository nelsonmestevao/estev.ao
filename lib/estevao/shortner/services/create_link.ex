defmodule Estevao.Shortner.Services.CreateLink do
  @moduledoc """
  A service module for creating a new link in the shortener service.

  This is the module that regular users should use when they want to create a
  new link. It takes a map of attributes, applies those attributes to a new
  `Link` struct via a changeset, and then attempts to save the new link into
  the database.

  ## Examples

      iex> Estevao.Shortner.Services.CreateLink.call(%{url: "https://example.com", slug: "my-unique_slug})
      iex> {:ok, %Link{}}
  """

  alias Estevao.Repo
  alias Estevao.Shortner.Link

  def call(attrs) do
    %Link{}
    |> Link.create_changeset(attrs)
    |> Repo.insert()
  end
end
