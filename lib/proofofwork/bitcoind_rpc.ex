
defmodule Proofofwork.BitcoindRpc do

  def getrawtransaction(txid, full) do

    rpchost = System.get_env("BITCOIND_RPC_HOST")
    rpcport = System.get_env("BITCOIND_RPC_PORT")
    rpcuser = System.get_env("BITCOIND_RPC_USER")
    rpcpassword = System.get_env("BITCOIND_RPC_PASSWORD")

    credentials = "#{rpcuser}:#{rpcpassword}" |> Base.encode64()
  
    headers = [
      {"Authorization", "Basic #{credentials}"}
    ]
  
    json = Jason.encode!(%{"method": "getrawtransaction", "params": [txid, full]})

    case HTTPoison.post("https://#{rpchost}:#{rpcport}", json, headers) do
  
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
  
        result = Jason.decode!(body)["result"]
  
        {:ok, result}
 
      {:ok, %HTTPoison.Response{status_code: 500, body: body}} ->
  
        error = Jason.decode!(body)["error"]
  
        {:error, error}
  
      {:error, %HTTPoison.Error{reason: reason}} ->
  
        IO.inspect reason
  
        {:error, reason}
  
    end

  end

end
