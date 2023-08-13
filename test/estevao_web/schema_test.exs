defmodule EstevaoWeb.SchemaTest do
  use EstevaoWeb.ConnCase

  import Estevao.ShortnerFixtures

  defp create_link(_) do
    link = link_fixture(slug: "sample", url: "https://example.com/create")
    %{link: link}
  end

  describe "graphql queries" do
    setup [:create_link, :login_as_admin]

    test "list_links", %{conn: conn} do
      conn =
        post(conn, ~p"/api/graphql", %{
          "query" => """
            query {
              links {
                url
                slug
                visits
              }
            }
          """
        })

      assert %{"data" => %{"links" => [%{"url" => "https://example.com/create", "slug" => "sample", "visits" => 0}]}} =
               json_response(conn, 200)
    end

    test "find_link", %{conn: conn} do
      conn =
        post(conn, ~p"/api/graphql", %{
          "query" => """
            query {
              link(slug: "sample") {
                url
                slug
                visits
              }
            }
          """
        })

      assert %{"data" => %{"link" => %{"url" => "https://example.com/create", "slug" => "sample", "visits" => 0}}} =
               json_response(conn, 200)
    end
  end

  describe "graphql mutations" do
    setup [:login_as_admin]

    test "create_link", %{conn: conn} do
      conn =
        post(conn, ~p"/api/graphql", %{
          "query" => """
            mutation {
              createLink(url: "https://example.com") {
                url
                slug
                visits
              }
            }
          """
        })

      assert %{"data" => %{"createLink" => %{"url" => "https://example.com", "slug" => _slug, "visits" => 0}}} =
               json_response(conn, 200)
    end
  end
end
