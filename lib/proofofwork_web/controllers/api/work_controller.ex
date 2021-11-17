import Ecto.Query

defmodule ProofofworkWeb.Api.WorkController do
  use ProofofworkWeb, :controller
  alias Proofofwork.Repo
  alias Proofofwork.Boost.JobProof

  def index(conn, _params) do
    query = from JobProof
      #order_by: [desc: :timestamp]

    transactions = Repo.all(query)

    json(conn, %{transactions: transactions})

  end
end
