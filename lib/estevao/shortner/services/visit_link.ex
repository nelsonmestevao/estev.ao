defmodule Estevao.Shortner.Services.VisitLink do
  @moduledoc """
  Increments the visit count of the link identified by the given slug and fetches the link.

  The increment operation is performed asynchronously.

  ## Params

  - `slug`: A string representing the slug of the link.

  ## Returns

  - The `Link` struct if the link is found, `nil` if the link is not found.

  ## Example

      iex> VisitLink.call("some-slug")
      %Estevao.Shortner.Link{}
  """

  alias Estevao.Repo
  alias Estevao.Shortner.Link
  alias Estevao.Shortner.Services.UpdateLinkVisits

  def call(slug) do
    UpdateLinkVisits.increment(slug)

    Repo.get_by(Link, slug: slug)
  end
end
