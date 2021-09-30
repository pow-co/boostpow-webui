defmodule Proofofwork.Repo.Migrations.AddSpentToBoostJob do
  use Ecto.Migration

  def change do

    alter table(:boost_jobs) do
      add :spent, :boolean, default: false
      add :spend_txid, :string
    end

  end
end
