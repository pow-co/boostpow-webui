defmodule Proofofwork.Repo.Migrations.CreateBestHashes do
  use Ecto.Migration

  def change do
    create table(:best_hashes) do
      add :publickey, :string
      add :besthash, :string
      add :os, :map
      add :hashes, :integer
      add :difficulty, :decimal
      add :content, :string

      timestamps()
    end

    create index(:best_hashes, [:publickey])
    create index(:best_hashes, [:content])

  end
end
