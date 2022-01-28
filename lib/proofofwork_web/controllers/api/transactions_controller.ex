
defmodule ProofofworkWeb.Api.TransactionsController do
  use ProofofworkWeb, :controller

  @rpchost System.get_env("BITCOIND_RPC_HOST")
  @rpcport System.get_env("BITCOIND_RPC_PORT")
  @rpchuser System.get_env("BITCOIND_RPC_USER")
  @rpcpassword System.get_env("BITCOIND_RPC_PASSWORD")

  def create(conn, %{"txid"=>txid}) do

    service_host = System.get_env("NODE_API_BASE")

    json = Jason.encode!(%{"txid": txid})

    case HTTPoison.post("#{service_host}", json) do

      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->

        result = Jason.decode!(body)["result"]

        IO.puts result

        json(conn, result)

      {:ok, %HTTPoison.Response{status_code: 500, body: body}} ->

        error = Jason.decode!(body)["error"]
        json(conn, %{txid: txid, error: error})

      {:error, %HTTPoison.Error{reason: reason}} ->

        json(conn, %{txid: txid, error: reason})
        IO.inspect reason
    end

  end

  def show(conn, %{"txid"=>txid}) do

    rpchost = System.get_env("BITCOIND_RPC_HOST")
    rpcport = System.get_env("BITCOIND_RPC_PORT")
    rpcuser = System.get_env("BITCOIND_RPC_USER")
    rpcpassword = System.get_env("BITCOIND_RPC_PASSWORD")

    credentials = "#{rpcuser}:#{rpcpassword}" |> Base.encode64()

    headers = [
      {"Authorization", "Basic #{credentials}"}
    ]

    case Proofofwork.BitcoindRpc.getrawtransaction(txid, true) do
      {:ok, result} ->
        tx = result

        case Proofofwork.BitcoindRpc.getrawtransaction(txid, false) do

          {:ok, hex} ->

            case Proofofwork.BitcoindRpc.getmerkleproof(txid) do

              {:ok, merkleproof} ->

                json(conn, %{txid: txid, txjson: tx, txhex: hex, merkleproof: merkleproof})

              {:error, %HTTPoison.Error{reason: reason}} ->
                IO.inspect reason
                json(conn, %{txid: txid, error: reason})

            end

          {:error, %HTTPoison.Error{reason: reason}} ->

            IO.inspect reason
            json(conn, %{txid: txid, error: reason})
        end


      {:error, %HTTPoison.Error{reason: reason}} ->

        IO.inspect reason
        json(conn, %{txid: txid, error: reason})

    end



  end
end
