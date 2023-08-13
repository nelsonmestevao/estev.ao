defmodule EstevaoWeb.Schema.EstevaoTypes do
  @moduledoc false
  use Absinthe.Schema.Notation

  @config Map.new(Mix.Project.config())

  object :app do
    field :name, non_null(:string)
    field :version, non_null(:string)
    field :description, :string
  end

  object :app_queries do
    field :app, non_null(:app) do
      resolve fn _parent, _args, _resolution ->
        {:ok, @config}
      end
    end
  end
end
