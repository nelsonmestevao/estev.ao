defmodule Estevao.ShortnerTest do
  use Estevao.DataCase

  alias Estevao.Shortner

  describe "links" do
    alias Estevao.Shortner.Link

    @valid_attrs %{slug: "example", url: "https://example.com"}
    @update_attrs %{slug: "short", url: "https://exemplo.pt", visits: 43}
    @invalid_attrs %{slug: nil, url: nil, visits: 10}

    def link_fixture(attrs \\ %{}) do
      {:ok, link} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Shortner.create_link()

      link
    end

    test "list_links/0 returns all links" do
      link = link_fixture()
      assert Shortner.list_links() == [link]
    end

    test "get_link!/1 returns the link with given id" do
      link = link_fixture()
      assert Shortner.get_link!(link.id) == link
    end

    test "create_link/1 with valid data creates a link" do
      assert {:ok, %Link{} = link} = Shortner.create_link(@valid_attrs)
      assert link.slug == "example"
      assert link.url == "https://example.com"
      assert link.visits == 0
    end

    test "create_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shortner.create_link(@invalid_attrs)
    end

    test "update_link/2 with valid data updates the link" do
      link = link_fixture()
      assert {:ok, %Link{} = link} = Shortner.update_link(link, @update_attrs)
      assert link.slug == "short"
      assert link.url == "https://exemplo.pt"
      assert link.visits == 43
    end

    test "update_link/2 with invalid data returns error changeset" do
      link = link_fixture()
      assert {:error, %Ecto.Changeset{}} = Shortner.update_link(link, @invalid_attrs)
      assert link == Shortner.get_link!(link.id)
    end

    test "delete_link/1 deletes the link" do
      link = link_fixture()
      assert {:ok, %Link{}} = Shortner.delete_link(link)
      assert_raise Ecto.NoResultsError, fn -> Shortner.get_link!(link.id) end
    end

    test "change_link/1 returns a link changeset" do
      link = link_fixture()
      assert %Ecto.Changeset{} = Shortner.change_link(link)
    end
  end
end
