defmodule Proofofwork.Content do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [
    :txid,
    :content_type,
    :content_json
  ]}

  schema "Contents" do
    field :txid, :string
    field :content_type, :string
    field :content_json, :map
  end

end
