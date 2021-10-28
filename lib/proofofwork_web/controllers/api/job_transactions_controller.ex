
defmodule ProofofworkWeb.Api.JobTransactionsController do
  use ProofofworkWeb, :controller

  def create(conn, %{"txid"=>txid}) do

    service_host = System.get_env("NODE_API_BASE")

    json = Jason.encode!(%{txid: txid})

    headers = %{"content-type": "application/json"}

    case HTTPoison.post("#{service_host}/node/api/boost_job_transactions", json, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        IO.puts body

        result = Jason.decode!(body)

        #IO.puts result

        json(conn, result)

      {:ok, %HTTPoison.Response{status_code: 500, body: body}} ->

        error = Jason.decode!(body)["error"]
        json(conn, %{txid: txid, error: error})

      {:error, %HTTPoison.Error{reason: reason}} ->

        json(conn, %{txid: txid, error: reason})
        IO.inspect reason
    end

  end

end
