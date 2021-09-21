import Ecto.Query

defmodule ProofofworkWeb.Api.JobsController do
  use ProofofworkWeb, :controller
  alias Proofofwork.Repo
  alias Proofofwork.PlanariaRecord

  def index(conn, params) do

    limit = params["limit"] || 25
    offset = params["offset"] || 0

    query = from PlanariaRecord,
      limit: ^limit,
      offset: ^offset,
      order_by: [desc: :inserted_at]

    jobs = Repo.all(query)
    json(conn, %{jobs: jobs})
  end

  def show(conn, %{"txid"=>txid}) do

    job = Repo.get_by!(PlanariaRecord, txid: txid)

    json(conn, %{job: job})
  end
end
