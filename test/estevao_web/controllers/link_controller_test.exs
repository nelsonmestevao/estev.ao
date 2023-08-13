defmodule EstevaoWeb.LinkControllerTest do
  use EstevaoWeb.ConnCase

  @create_attrs %{
    url: "https://example.com",
    slug: "example-slug"
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create link" do
    test "renders link when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/links", link: @create_attrs)
      assert %{"slug" => slug} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/links/#{slug}")

      assert %{
               "slug" => ^slug,
               "url" => "https://example.com",
               "visits" => 0
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/links", link: %{url: "invalid"})
      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end
