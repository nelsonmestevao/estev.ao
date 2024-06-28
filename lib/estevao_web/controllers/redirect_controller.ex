defmodule EstevaoWeb.RedirectController do
  use EstevaoWeb, :controller

  alias Estevao.Shortner.Handlers.Links

  def show(conn, %{"slug" => slug}) do
    case Links.visit_link(slug) do
      nil ->
        conn
        |> put_flash(:error, "Link not found")
        |> redirect(to: "/")

      link ->
        conn
        |> put_status(:temporary_redirect)
        |> redirect(external: link.url)
    end
  end
end
