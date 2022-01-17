
import Ecto.Query

defmodule Proofofwork.ContentCache do
  alias Proofofwork.Repo
  alias Proofofwork.Content

  defp cache_content txid do

    case HTTPoison.get("https://pow.co/node/api/content/#{txid}") do
  
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        result = Jason.decode!(body)["content"]

        {:ok, result}
  
      {:error, %HTTPoison.Error{reason: reason}} ->
  
        IO.inspect reason
  
        {:error, reason}
  
    end

  end

  def fetch txid do

    content = Repo.one(from Content, where: [txid: ^txid])

    unless content do

      cache_content txid

    end

    content = Repo.one!(from Content, where: [txid: ^txid])

  end

end
