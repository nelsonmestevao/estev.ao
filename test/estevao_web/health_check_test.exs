defmodule EstevaoWeb.HealthCheckTest do
  use EstevaoWeb.ConnCase, async: true

  test "GET /health", %{conn: conn} do
    assert conn
           |> get(~p"/health")
           |> text_response(200) == "OK"
  end

  test "GET /_version", %{conn: conn} do
    assert conn
           |> get(~p"/_version")
           |> text_response(200) == Estevao.version()
  end

  test "GET /_about.json", %{conn: conn} do
    assert conn
           |> get(~p"/_about.json")
           |> json_response(200) == %{
             "app" => "estevao",
             "description" => "A short and simple redirecting service"
           }
  end
end
