import Ecto.Query

defmodule ProofofworkWeb.Api.JobsController do
  use ProofofworkWeb, :controller
  alias Proofofwork.Repo
  alias Proofofwork.BoostJob

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

    query = from BoostJob,
      limit: ^limit,
      offset: ^offset,
      order_by: [{^direction, ^order_by}],
      where: ^where

    jobs = Repo.all(query)
    json(conn, %{jobs: jobs})
  end

  def show(conn, %{"txid"=>txid}) do

    job = Repo.get_by!(BoostJob, txid: txid)

    json(conn, %{job: job})
  end
end
