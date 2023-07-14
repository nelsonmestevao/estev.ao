defmodule Estevao.ShortnerServicesTest do
  use Estevao.DataCase, async: true

  alias Estevao.Shortner.Link
  alias Estevao.Shortner.Services.CreateLink

  doctest Estevao.Shortner.Services.ChangeLink

  describe "CreateLink.call/1" do
    test "creates a link with valid attributes" do
      {:ok, link} = CreateLink.call(%{url: "https://example.com", slug: "my-unique_slug"})

      assert link.url == "https://example.com"
      assert link.slug == "my-unique_slug"
      assert link.visits == 0
    end

    test "automatically generates a slug when one is not provided" do
      {:ok, link} = CreateLink.call(%{url: "https://example.com/hello"})

      assert link.slug != ""
      assert link.url == "https://example.com/hello"
      assert link.visits == 0
    end

    test "ignores the visits field when creating a link" do
      {:ok, link} = CreateLink.call(%{url: "https://example.com/hi", visits: 50})

      assert link.url == "https://example.com/hi"
      assert link.visits == 0
    end

    test "does not create a link with invalid attributes" do
      assert {:error, %Ecto.Changeset{}} = CreateLink.call(%{slug: "my-slug"})
    end
  end
end
