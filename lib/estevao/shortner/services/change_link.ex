defmodule Estevao.Shortner.Services.ChangeLink do
  @moduledoc """
    A service module for creating a Ecto.Changeset for an existing link.

  ## Examples

      iex> link = %Link{id: 1, url: "https://example.com", slug: "ex"}
      iex> attrs = %{url: "https://new-example.com"}
      iex> Estevao.Shortner.Services.ChangeLink.call(link, attrs)
      #Ecto.Changeset<action: nil, changes: %{url: "https://new-example.com"}, errors: [], data: #Estevao.Shortner.Link<>, valid?: true, ...>
  """

  alias Estevao.Shortner.Link

  @spec call(Link.t()) :: Ecto.Changeset.t()
  @spec call(Link.t(), map()) :: Ecto.Changeset.t()
  def call(%Link{} = link, attrs \\ %{}) do
    Link.create_changeset(link, attrs)
  end
end
