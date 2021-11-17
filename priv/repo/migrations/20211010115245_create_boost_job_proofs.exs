defmodule Proofofwork.Repo.Migrations.CreateBoostJobProofs do
  use Ecto.Migration

  def change do
    create table(:boost_job_proofs) do
      add :spend_txid, :string
      add :spend_vout, :integer
      add :job_txid, :string
      add :job_vout, :integer
      add :signature, :string
      add :content, :string
      add :timestamp, :naive_datetime

      timestamps()
    end

  end
end
