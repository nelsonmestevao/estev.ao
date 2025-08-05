defmodule EstevaoWeb.RedirectControllerTest do
  use EstevaoWeb.ConnCase, async: true

  import Estevao.ShortnerFixtures

  alias Estevao.Shortner

  setup %{conn: conn} do
    {:ok, conn: conn, link: link_fixture()}
  end

  describe "show/2" do
    test "redirects to the link's URL if the link exists", %{conn: conn, link: link} do
      assert conn
             |> get(~p"/#{link.slug}")
             |> redirected_to(307) == link.url

      assert Shortner.get_link!(link.id).visits == 1
    end

    test "redirects to root with an error message if the link does not exist", %{conn: conn} do
      conn = get(conn, ~p"/non_existent_slug")

      assert Phoenix.Flash.get(conn.assigns.flash, :error) == "Link not found"
      assert redirected_to(conn, 302) == "/"
    end
  end
end
