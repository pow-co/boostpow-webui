defmodule Proofofwork.Repo.Migrations.IndexBoostJobTxidAndSpent do
  use Ecto.Migration

  def change do

    create index("boost_jobs", [:txid, :spent], comment: "Index Boost Job Txid and Spent")

    alter table("boost_jobs") do
      add :spent_txid, :string
      add :spent_vout, :integer
    end

  end
end
