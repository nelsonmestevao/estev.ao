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

  import Ecto.Query

  alias Estevao.Repo
  alias Estevao.Shortner.Link

  def call(slug) do
    query =
      link_by_slug_query(slug)

    Task.start(fn ->
      Repo.update_all(query, inc: [visits: 1])
    end)

    Repo.one(query)
  end

  defp link_by_slug_query(slug) do
    from l in Link,
      where: l.slug == ^slug
  end
end
