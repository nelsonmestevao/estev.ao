defmodule EstevaoWeb.HomeLiveTest do
  use EstevaoWeb.ConnCase, async: true

  import Estevao.ShortnerFixtures

  test "can create a link", %{conn: conn} do
    {:ok, home_live, html} = live(conn, "/")

    assert html =~ "estev.ao"
    assert html =~ "Type your URL..."

    assert html =
             home_live
             |> form("#link-form", link: %{"url" => "http://example.com", "slug" => "example"})
             |> render_submit()

    assert html =~ "Type your URL..."
    assert html =~ "Copy"

    assert {:ok, conn} =
             home_live
             |> element("a")
             |> render_click()
             |> follow_redirect(conn)

    assert redirected_to(conn, 307) =~ "http://example.com"
  end

  test "form validates inputs and shows errors", %{conn: conn} do
    link_fixture(slug: "test-slug")
    {:ok, home_live, _html} = live(conn, "/")

    assert html =
             home_live
             |> form("#link-form", link: %{"url" => "http://example", "slug" => "test-slug"})
             |> render_change()

    assert html =~ "invalid URL"
    refute html =~ "has already been taken"

    assert html =
             home_live
             |> form("#link-form", link: %{"url" => "http://example.com", "slug" => "test-slug"})
             |> render_submit()

    refute html =~ "invalid URL"
    assert html =~ "has already been taken"
  end
end
