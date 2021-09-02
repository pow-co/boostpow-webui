defmodule Proofofwork.Repo.Migrations.CreatePlanariaRecord do
  use Ecto.Migration

  def change do
    create table(:planaria_records) do
      add :_id, :string
      add :txid, :string
      add :block_hash, :string
      add :block_height, :integer
      add :time, :integer
      add :tx, :map

      timestamps()
    end

    create unique_index(:planaria_records, [:_id])
    create unique_index(:planaria_records, [:txid])

  end
end
