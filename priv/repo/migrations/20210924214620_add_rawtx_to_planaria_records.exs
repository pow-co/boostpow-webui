defmodule Proofofwork.Repo.Migrations.AddRawtxToPlanariaRecords do
  use Ecto.Migration

  def change do

    alter table(:planaria_records) do
      add :rawtx, :binary
    end

  end
end
