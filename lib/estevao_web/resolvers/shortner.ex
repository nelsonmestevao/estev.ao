defmodule EstevaoWeb.Resolvers.Shortner do
  @moduledoc false
  alias Estevao.Shortner

  def list_links(_parent, _args, _resolution) do
    {:ok, Shortner.list_links()}
  end

  def find_link(_parent, %{slug: slug}, _resolution) do
    case Shortner.get_link(slug: slug) do
      nil ->
        {:error, "Link #{slug} not found"}

      link ->
        {:ok, link}
    end
  end

  def create_link(_parent, args, _resolution) do
    Shortner.create_link(args)
  end
end
