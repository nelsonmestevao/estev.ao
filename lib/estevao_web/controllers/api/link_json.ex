defmodule EstevaoWeb.LinkJSON do
  alias Estevao.Shortner.Link

  @doc """
  Renders a single link.
  """
  def show(%{link: link}) do
    %{data: data(link)}
  end

  defp data(%Link{} = link) do
    %{
      url: link.url,
      slug: link.slug,
      visits: link.visits
    }
  end
end
