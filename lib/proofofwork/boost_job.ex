defmodule Proofofwork.BoostJob do
  use Ecto.Schema
  import Ecto.Changeset
  @derive {Jason.Encoder, only: [:content, :difficulty, :category, :tag, :txid, :value, :vout, :timestamp, :additionalData]}

  schema "boost_jobs" do
    field :additionalData, :string
    field :category, :string
    field :content, :string
    field :difficulty, :decimal
    field :tag, :string
    field :timestamp, :naive_datetime
    field :txid, :string
    field :userNonce, :string
    field :value, :integer
    field :vout, :integer

    timestamps()
  end

  @doc false
  def changeset(boost_job, attrs) do
    boost_job
    |> cast(attrs, [:content, :difficulty, :category, :tag, :additionalData, :userNonce, :txid, :vout, :value, :timestamp])
    |> validate_required([:content, :difficulty, :category, :tag, :additionalData, :userNonce, :txid, :vout, :value, :timestamp])
  end
end
