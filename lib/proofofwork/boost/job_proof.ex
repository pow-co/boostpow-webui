defmodule Proofofwork.Boost.JobProof do
  use Ecto.Schema
  import Ecto.Changeset

  schema "boost_job_proofs" do
    field :job_txid, :string
    field :job_vout, :string
    field :spend_txid, :string
    field :spend_vout, :integer
    field :signature, :string
    field :content, :string
    field :timestamp, :naive_datetime

    timestamps()
  end

  @doc false
  def changeset(job_proof, attrs) do
    job_proof
    |> cast(attrs, [:spend_txid, :spend_vout, :timestamp, :job_txid, :job_vout, :content])
    |> validate_required([:spend_txid, :spend_vout, :timestamp, :job_txid, :job_vout, :content])
  end
end
