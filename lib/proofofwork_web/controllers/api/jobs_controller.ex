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

    response = %{job: job}

    json(conn, response)
  end

  def date_range(conn, params = %{"start_date"=>start_date, "end_date"=> end_date}) do

    {:ok, start_date} = NaiveDateTime.new Date.from_iso8601!(start_date), ~T[00:00:00]
    {:ok, end_date} = NaiveDateTime.new Date.from_iso8601!(end_date), ~T[00:00:00]

    query = if params["content"] do

      BoostJob
      |> where([p], p.timestamp >= ^start_date)
      |> where([p], p.timestamp <= ^end_date)
      |> where([p], p.content == ^params["content"])

    else

      BoostJob
      |> where([p], p.timestamp >= ^start_date)
      |> where([p], p.timestamp <= ^end_date)

    end

    jobs = query |> Repo.all

    json(conn, %{jobs: jobs})

  end
end
