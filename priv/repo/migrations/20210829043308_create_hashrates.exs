defmodule Proofofwork.Repo.Migrations.CreateHashrates do
  use Ecto.Migration

  def change do
    create table(:hashrates) do
      add :hashrate, :decimal
      add :ipv4, :string
      add :publickey, :string
      add :content, :string
      add :difficulty, :decimal

      timestamps()
    end

    create index(:hashrates, [:publickey])
    create index(:hashrates, [:content])

  end
end
