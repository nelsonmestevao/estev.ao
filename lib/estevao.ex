defmodule Estevao do
  @moduledoc """
  Estevao keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  @app Mix.Project.config()[:app]
  @version Mix.Project.config()[:version]
  @env Mix.env()

  def version, do: "#{@version}-#{@env}+#{String.slice(commit_hash(), 0, 8)}"
  def commit_hash, do: Application.get_env(@app, :commit_hash)

  def schema do
    quote do
      use Ecto.Schema

      import Ecto.Changeset
      import ExToolkit.Ecto.Changeset

      @type t :: %__MODULE__{
              __meta__: Ecto.Schema.Metadata.t(),
              id: id?()
            }

      @type t? :: nil | t()

      @type id :: binary()
      @type id? :: nil | id()

      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id

      @timestamps_opts [type: :utc_datetime]
    end
  end

  @doc """
  When used, dispatch to the appropriate finder/schema/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
