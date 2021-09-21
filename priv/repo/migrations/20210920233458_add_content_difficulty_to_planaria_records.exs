defmodule Proofofwork.Repo.Migrations.AddContentDifficultyToPlanariaRecords do
  use Ecto.Migration

  def change do

    alter table(:planaria_records) do
      add :content, :string
      add :difficulty, :decimal
    end

  end
end
