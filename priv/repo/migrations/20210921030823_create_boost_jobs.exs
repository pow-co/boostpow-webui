defmodule Proofofwork.Repo.Migrations.CreateBoostJobs do
  use Ecto.Migration

  def change do
    create table(:boost_jobs) do
      add :content, :string
      add :difficulty, :decimal
      add :category, :string
      add :tag, :text
      add :additionalData, :text
      add :userNonce, :string
      add :txid, :string
      add :vout, :integer
      add :value, :integer
      add :timestamp, :naive_datetime

      timestamps()
    end

    create unique_index(:boost_jobs, [:txid])
    create index(:boost_jobs, [:category])

  end
end
