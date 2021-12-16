
defmodule ProofofworkWeb.Api.ProofTransactionsController do
  use ProofofworkWeb, :controller

  def create(conn, %{"transaction"=>transaction}) do

    service_host = System.get_env("NODE_API_BASE")

    json = Jason.encode!(%{transaction: transaction})

    headers = %{"content-type": "application/json"}

    case HTTPoison.post("#{service_host}/node/api/boost_proof_transactions", json, headers) do

      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        IO.puts body

        result = Jason.decode!(body)

        json(conn, result)

      {:ok, %HTTPoison.Response{status_code: 500, body: body}} ->

        error = Jason.decode!(body)["error"]
        json(conn, %{transaction: transaction, error: error})

      {:error, %HTTPoison.Error{reason: reason}} ->

        json(conn, %{transaction: transaction, error: reason})
        IO.inspect reason
    end

  end

end
