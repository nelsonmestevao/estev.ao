defmodule Estevao.Shortner.Services.UpdateLinkVisits do
  @moduledoc false
  use GenServer

  import Ecto.Query

  alias Estevao.Repo
  alias Estevao.Shortner.Link

  # Client API

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def increment(slug) do
    GenServer.cast(__MODULE__, {:increment, slug})
  end

  # Server callbacks

  def init(_) do
    {:ok, nil}
  end

  def handle_cast({:increment, slug}, _state) do
    query =
      from l in Link,
        where: l.slug == ^slug

    Repo.update_all(query, inc: [visits: 1])

    {:noreply, nil}
  end
end
