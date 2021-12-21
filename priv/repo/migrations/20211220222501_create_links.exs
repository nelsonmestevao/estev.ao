defmodule Estevao.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :slug, :string, null: false
      add :url, :string, null: false
      add :visits, :integer

      timestamps()
    end

    create unique_index(:links, [:slug])
  end
end
