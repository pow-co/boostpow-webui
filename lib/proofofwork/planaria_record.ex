defmodule Proofofwork.PlanariaRecord do
  use Ecto.Schema
  import Ecto.Changeset

  schema "planaria_records" do
    field :_id, :string
    field :block_hash, :string
    field :block_height, :integer
    field :time, :integer
    field :tx, :map
    field :txid, :string

    timestamps()
  end

  @doc false
  def changeset(planaria_record, attrs) do
    planaria_record
    |> cast(attrs, [:_id, :txid, :block_hash, :block_height, :time, :tx])
    |> validate_required([:_id, :txid, :block_hash, :block_height, :time, :tx])
  end
end
