defmodule Proofofwork.Repo.Migrations.AddDifficultyToBoostJobProof do
  use Ecto.Migration

  def change do

    alter table(:boost_job_proofs) do
      add :difficulty, :decimal
    end

  end
end
