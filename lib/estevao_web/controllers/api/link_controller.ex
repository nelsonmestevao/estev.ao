defmodule EstevaoWeb.LinkController do
  use EstevaoWeb, :controller

  alias Estevao.Shortner
  alias Estevao.Shortner.Link
  alias Estevao.Shortner.Services.CreateLink

  action_fallback EstevaoWeb.FallbackController

  def create(conn, %{"link" => link_params}) do
    with {:ok, %Link{} = link} <- CreateLink.call(link_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/links/#{link}")
      |> render(:show, link: link)
    end
  end

  def show(conn, %{"slug" => slug}) do
    link = Shortner.get_link!(slug: slug)
    render(conn, :show, link: link)
  end
end
