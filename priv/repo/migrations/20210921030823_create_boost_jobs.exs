defmodule Proofofwork.Repo.Migrations.CreateBoostJobs do
  use Ecto.Migration

  def change do

    create table(:boost_jobs) do
      add :content, :string, null: false
      add :difficulty, :decimal, null: false
      add :category, :string
      add :tag, :text
      add :additionalData, :text
      add :userNonce, :string
      add :txid, :string, null: false
      add :vout, :integer, null: false
      add :value, :integer, null: false
      add :timestamp, :naive_datetime, null: false

      timestamps()
    end

    create unique_index(:boost_jobs, [:txid])
    create index(:boost_jobs, [:category])

  end
end
