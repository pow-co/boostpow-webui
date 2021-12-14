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

  def since_date(conn, %{"date"=>date}) do

    {:ok, date} = NaiveDateTime.new Date.from_iso8601!(date), ~T[00:00:00]

    work = JobProof
    |> where([p], p.timestamp >= ^date)
    |> Repo.all

    json(conn, %{work: work})

  end

  def date_range(conn, params = %{"start_date"=>start_date, "end_date"=> end_date}) do

    {:ok, start_date} = NaiveDateTime.new Date.from_iso8601!(start_date), ~T[00:00:00]
    {:ok, end_date} = NaiveDateTime.new Date.from_iso8601!(end_date), ~T[00:00:00]

    query = if params["content"] do

      JobProof
      |> where([p], p.timestamp >= ^start_date)
      |> where([p], p.timestamp <= ^end_date)
      |> where([p], p.content == ^params["content"])

    else

      JobProof
      |> where([p], p.timestamp >= ^start_date)
      |> where([p], p.timestamp <= ^end_date)

    end

    work = query |> Repo.all

    json(conn, %{work: work})

  end

end
