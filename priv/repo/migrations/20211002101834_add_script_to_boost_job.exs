defmodule Proofofwork.Repo.Migrations.AddScriptToBoostJob do
  use Ecto.Migration

  def change do

    alter table(:boost_jobs) do 
      add :script, :text
    end

  end
end
