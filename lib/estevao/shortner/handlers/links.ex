defmodule Estevao.Shortner.Handlers.Links do
  @moduledoc false

  alias Estevao.Shortner.Link
  alias Estevao.Shortner.Services.ChangeLink
  alias Estevao.Shortner.Services.CreateLink
  alias Estevao.Shortner.Services.VisitLink

  @spec new_link() :: Ecto.Changeset.t()
  def new_link, do: change_link()

  @spec change_link() :: Ecto.Changeset.t()
  @spec change_link(Link.t()) :: Ecto.Changeset.t()
  @spec change_link(Link.t(), map()) :: Ecto.Changeset.t()
  defdelegate change_link(link \\ %Link{}, attrs \\ %{}), to: ChangeLink, as: :call

  @spec create_link(map()) :: {:ok, Link.t()} | {:error, Ecto.Changeset.t()}
  defdelegate create_link(attrs), to: CreateLink, as: :call

  @spec visit_link(Link.slug()) :: Link.t?()
  defdelegate visit_link(slug), to: VisitLink, as: :call
end
