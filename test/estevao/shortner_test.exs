defmodule Estevao.ShortnerTest do
  use Estevao.DataCase

  alias Estevao.Shortner

  describe "links" do
    alias Estevao.Shortner.Link

    import Estevao.ShortnerFixtures

    @invalid_attrs %{slug: nil, url: nil, visits: nil}

    test "list_links/0 returns all links" do
      link = link_fixture()
      assert Shortner.list_links() == [link]
    end

    test "get_link!/1 returns the link with given id" do
      link = link_fixture()
      assert Shortner.get_link!(link.id) == link
    end

    test "create_link/1 with valid data creates a link" do
      valid_attrs = %{slug: "some slug", url: "some url", visits: 42}

      assert {:ok, %Link{} = link} = Shortner.create_link(valid_attrs)
      assert link.slug == "some slug"
      assert link.url == "some url"
      assert link.visits == 42
    end

    test "create_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shortner.create_link(@invalid_attrs)
    end

    test "update_link/2 with valid data updates the link" do
      link = link_fixture()
      update_attrs = %{slug: "some updated slug", url: "some updated url", visits: 43}

      assert {:ok, %Link{} = link} = Shortner.update_link(link, update_attrs)
      assert link.slug == "some updated slug"
      assert link.url == "some updated url"
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
