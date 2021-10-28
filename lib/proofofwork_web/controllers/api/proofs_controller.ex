import Ecto.Query

defmodule ProofofworkWeb.Api.ProofsController do
  use ProofofworkWeb, :controller
  alias Proofofwork.Repo
  alias Proofofwork.BoostJob
  alias Proofofwork.Boost.JobProof

  def index(conn, params) do

    limit = params["limit"] || 25
    offset = params["offset"] || 0
    order_by = case !!params["order_by"] do
      true ->
        String.to_existing_atom(params["order_by"])
      false -> 
        :inserted_at
    end

    direction = case params["order_direction"] do
      "asc" -> :asc
      "desc" -> :desc
      _ -> :desc
    end

    where = if params["category"] do
      [category: params["category"]]
    else 
      []
    end

    where = if params["content"] do
      [content: params["content"]]
    else
      where
    end

    query = from JobProof,
      limit: ^limit,
      offset: ^offset,
      order_by: [{^direction, ^order_by}],
      where: ^where

    proofs = Repo.all(query)
    json(conn, %{proofs: proofs})
  end

  def show(conn, %{"txid"=>txid}) do

    job = Repo.get_by!(BoostJob, txid: txid)

    response = %{job: job}

    json(conn, response)
  end
end