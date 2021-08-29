defmodule Proofofwork.Hashrate do
  use Ecto.Schema
  import Ecto.Changeset

  schema "hashrates" do
    field :content, :string
    field :difficulty, :decimal
    field :hashrate, :decimal
    field :ipv4, :string
    field :publickey, :string

    timestamps()
  end

  @doc false
  def changeset(hashrate, attrs) do
    hashrate
    |> cast(attrs, [:hashrate, :ipv4, :publickey, :content, :difficulty])
    |> validate_required([:hashrate, :ipv4, :publickey, :content, :difficulty])
  end
end
