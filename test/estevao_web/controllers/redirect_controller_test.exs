defmodule EstevaoWeb.RedirectControllerTest do
  use EstevaoWeb.ConnCase

  alias Estevao.Shortner

  setup %{conn: conn} do
    {:ok, link} = Shortner.create_link(%{url: "https://example.com", slug: "sample-slug"})
    {:ok, conn: conn, link: link}
  end

  describe "show/2" do
    test "redirects to the link's URL if the link exists", %{conn: conn, link: link} do
      conn = get(conn, ~p"/#{link.slug}")

      assert conn.status == 307
      assert hd(get_resp_header(conn, "location")) == link.url

      Process.sleep(10)

      assert Shortner.get_link!(link.id).visits == 1
    end

    test "redirects to root with an error message if the link does not exist", %{conn: conn} do
      conn = get(conn, ~p"/non_existent_slug")

      assert conn.status == 302
      assert Phoenix.Flash.get(conn.assigns.flash, :error) == "Link not found"
      assert redirected_to(conn) == "/"
    end
  end
end
