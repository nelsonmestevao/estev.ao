defmodule Estevao.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :content, :string
      add :username, :string
      add :room_id, :string

      timestamps()
    end
  end
end
