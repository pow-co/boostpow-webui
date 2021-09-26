
defmodule ProofofworkWeb.Api.TransactionsController do
  use ProofofworkWeb, :controller

  def show(conn, %{"txid"=>txid}) do

    credentials = "CHANGE_ME:CHANGE_ME" |> Base.encode64()

    headers = [
      #{"Content-Type", "application/json"},
      {"Authorization", "Basic #{credentials}"}
    ]

    json = Jason.encode!(%{"method": "getrawtransaction", "params": ["#{txid}"]})

    #{:ok, response} = HTTPoison.post("http://54.174.1.24:9332", '{"method": "getrawtransaction", "params": [\"#{txid}\"]', headers)
    case HTTPoison.post("http://54.174.1.24:9332", json, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        rawtx = Jason.decode!(body)["result"]
        IO.puts rawtx
        json(conn, %{txid: txid, rawtx: rawtx})
      {:ok, %HTTPoison.Response{status_code: 500, body: body}} ->
        error = Jason.decode!(body)["error"]
        json(conn, %{txid: txid, error: error})
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end

    #json(conn, response.body)

  end
end
