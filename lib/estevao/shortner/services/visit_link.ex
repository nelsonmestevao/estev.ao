defmodule Estevao.Shortner.Services.VisitLink do
  @moduledoc """
  Increments the visit count of the link identified by the given slug and fetches the link.

  The increment operation is performed asynchronously.

  ## Example

      iex> VisitLink.call("some-slug")
      %Estevao.Shortner.Link{}
  """

  import Ecto.Query

  alias Estevao.Repo
  alias Estevao.Shortner.Link

  @spec call(Link.slug()) :: Link.t?()
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
