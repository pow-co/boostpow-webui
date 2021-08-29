defmodule Proofofwork.BestHash do
  use Ecto.Schema
  import Ecto.Changeset

  schema "best_hashes" do
    field :besthash, :string
    field :content, :string
    field :difficulty, :decimal
    field :hashes, :integer
    field :os, :map
    field :publickey, :string
    field :ipv4, :string

    timestamps()
  end

  @doc false
  def changeset(best_hash, attrs) do
    best_hash
    |> cast(attrs, [:publickey, :besthash, :os, :hashes, :difficulty, :content])
    |> validate_required([:publickey, :besthash, :os, :hashes, :difficulty, :content])
  end
end
