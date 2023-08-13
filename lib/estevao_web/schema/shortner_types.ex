defmodule EstevaoWeb.Schema.ShortnerTypes do
  @moduledoc false
  use Absinthe.Schema.Notation

  object :link do
    field :url, :string
    field :slug, :string
    field :visits, :integer
  end
end
