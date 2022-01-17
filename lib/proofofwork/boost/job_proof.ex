defmodule Proofofwork.Boost.JobProof do
  use Ecto.Schema
  import Ecto.Changeset
  @derive {Jason.Encoder, only: [
    :job_txid,
    :job_vout,
    :spend_txid,
    :spend_vout,
    :signature,
    :content,
    :value,
    :difficulty,
    :timestamp
  ]}

  schema "boost_job_proofs" do
    field :job_txid, :string
    field :job_vout, :integer
    field :spend_txid, :string
    field :spend_vout, :integer
    field :signature, :string
    field :content, :string
    field :value, :integer
    field :difficulty, :decimal
    field :timestamp, :naive_datetime

    timestamps()
  end

  @doc false
  def changeset(job_proof, attrs) do
    job_proof
    |> cast(attrs, [:spend_txid, :spend_vout, :timestamp, :job_txid, :job_vout, :content, :difficulty])
    |> validate_required([:spend_txid, :spend_vout, :timestamp, :job_txid, :job_vout, :content])
  end
end
