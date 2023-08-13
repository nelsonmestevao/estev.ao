defmodule EstevaoWeb.Schema do
  @moduledoc false
  use Absinthe.Schema

  alias EstevaoWeb.Resolvers

  import_types EstevaoWeb.Schema.EstevaoTypes
  import_types EstevaoWeb.Schema.ShortnerTypes

  query do
    import_fields :app_queries

    @desc "Get all links"
    field :links, list_of(:link) do
      resolve &Resolvers.Shortner.list_links/3
    end

    @desc "Get a link by slug"
    field :link, :link do
      arg :slug, non_null(:string)
      resolve &Resolvers.Shortner.find_link/3
    end
  end

  mutation do
    @desc "Create a link"
    field :create_link, type: :link do
      arg :url, non_null(:string)
      arg :slug, :string
      arg :visits, :integer

      resolve &Resolvers.Shortner.create_link/3
    end
  end
end
