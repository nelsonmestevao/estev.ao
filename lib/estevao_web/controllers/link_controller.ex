defmodule EstevaoWeb.LinkController do
  use EstevaoWeb, :controller

  alias Estevao.Shortner

  def show(conn, %{"slug" => slug}) do
    case Shortner.get_link(slug: slug) do
      nil ->
        conn
        |> put_flash(:error, "Invalid link")
        |> redirect(to: "/")

      link ->
        conn
        |> render("show.html", link: link)
    end
  end

  def redirect_to(conn, %{"slug" => slug}) do
    case Shortner.get_link(slug: slug) do
      nil ->
        conn
        |> put_flash(:error, "Invalid link")
        |> redirect(to: "/")

      link ->
        Task.start(fn -> Shortner.update_link(link, %{visits: link.visits + 1}) end)
        redirect(conn, external: link.url)
    end
  end
end
