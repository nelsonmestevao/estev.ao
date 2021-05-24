defmodule EstevaoWeb.PageLiveTest do
  use EstevaoWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "A short and simple redirecting service"
    assert render(page_live) =~ "A short and simple redirecting service"
  end
end
