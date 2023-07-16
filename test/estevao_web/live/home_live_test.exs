defmodule EstevaoWeb.HomeLiveTest do
  use EstevaoWeb.ConnCase

  import Phoenix.LiveViewTest

  test "can create a link", %{conn: conn} do
    {:ok, home_live, html} = live(conn, "/")

    assert html =~ "estev.ao"
    assert html =~ "Type your URL..."

    assert html =
             home_live
             |> form("#link-form", link: %{"url" => "http://example.com", "slug" => "example"})
             |> render_submit()

    assert html =~ "Type your URL..."
  end
end
