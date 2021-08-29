defmodule Proofofwork.Repo.Migrations.CreateSolutions do
  use Ecto.Migration

  def change do
    create table(:solutions) do
      add :content, :string
      add :solution, :string
      add :difficulty, :decimal
      add :os, :map
      add :publickey, :string
      add :ipv4, :string

      timestamps()
    end

    alter table(:best_hashes) do
      add :ipv4, :string
    end

  end
end
