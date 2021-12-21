defmodule Estevao.ShortnerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Estevao.Shortner` context.
  """

  @doc """
  Generate a link.
  """
  def link_fixture(attrs \\ %{}) do
    {:ok, link} =
      attrs
      |> Enum.into(%{
        slug: "some slug",
        url: "some url",
        visits: 42
      })
      |> Estevao.Shortner.create_link()

    link
  end
end
