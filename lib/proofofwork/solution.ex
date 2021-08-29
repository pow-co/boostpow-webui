defmodule Proofofwork.Solution do
  use Ecto.Schema
  import Ecto.Changeset

  schema "solutions" do
    field :content, :string
    field :difficulty, :decimal
    field :ipv4, :string
    field :os, :map
    field :publickey, :string
    field :solution, :string

    timestamps()
  end

  @doc false
  def changeset(solution, attrs) do
    solution
    |> cast(attrs, [:content, :solution, :difficulty, :os, :publickey, :ipv4])
    |> validate_required([:content, :solution, :difficulty, :os, :publickey, :ipv4])
  end
end
