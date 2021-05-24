defmodule EstevaoWeb.LinkControllerTest do
  use EstevaoWeb.ConnCase

  alias Estevao.Shortner

  @create_attrs %{slug: "some slug", url: "some url", visits: 42}
  @update_attrs %{slug: "some updated slug", url: "some updated url", visits: 43}
  @invalid_attrs %{slug: nil, url: nil, visits: nil}

  def fixture(:link) do
    {:ok, link} = Shortner.create_link(@create_attrs)
    link
  end

  describe "index" do
    test "lists all links", %{conn: conn} do
      conn = get(conn, Routes.link_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Links"
    end
  end

  describe "new link" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.link_path(conn, :new))
      assert html_response(conn, 200) =~ "New Link"
    end
  end

  describe "create link" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.link_path(conn, :create), link: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.link_path(conn, :show, id)

      conn = get(conn, Routes.link_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Link"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.link_path(conn, :create), link: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Link"
    end
  end

  describe "edit link" do
    setup [:create_link]

    test "renders form for editing chosen link", %{conn: conn, link: link} do
      conn = get(conn, Routes.link_path(conn, :edit, link))
      assert html_response(conn, 200) =~ "Edit Link"
    end
  end

  describe "update link" do
    setup [:create_link]

    test "redirects when data is valid", %{conn: conn, link: link} do
      conn = put(conn, Routes.link_path(conn, :update, link), link: @update_attrs)
      assert redirected_to(conn) == Routes.link_path(conn, :show, link)

      conn = get(conn, Routes.link_path(conn, :show, link))
      assert html_response(conn, 200) =~ "some updated slug"
    end

    test "renders errors when data is invalid", %{conn: conn, link: link} do
      conn = put(conn, Routes.link_path(conn, :update, link), link: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Link"
    end
  end

  describe "delete link" do
    setup [:create_link]

    test "deletes chosen link", %{conn: conn, link: link} do
      conn = delete(conn, Routes.link_path(conn, :delete, link))
      assert redirected_to(conn) == Routes.link_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.link_path(conn, :show, link))
      end
    end
  end

  defp create_link(_) do
    link = fixture(:link)
    %{link: link}
  end
end
