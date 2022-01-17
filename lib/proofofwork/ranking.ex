
import Ecto.Query

defmodule Proofofwork.Ranking do
  alias Proofofwork.Repo
  alias Proofofwork.Content

  def top_content do

    case HTTPoison.get("https://pow.co/node/v1/ranking/value?limit=1000&offset=0&content_category=image") do
  
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        result = Jason.decode!(body)["content"]

        {:ok, result}
  
      {:error, %HTTPoison.Error{reason: reason}} ->
  
        IO.inspect reason
  
        {:error, reason}
  
    end

  end

  def top_content :all do

    #case HTTPoison.get("https://pow.co/node/v1/ranking/value?limit=100&offset=0") do
    case HTTPoison.get("https://pow.co/node/v1/ranking") do
  
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->

        result = Jason.decode!(body)["content"]

        result = Enum.map(result, fn (item) ->

          txid = item["content"]

          record = Repo.one!(from Content, where: [txid: ^txid])

          Map.merge(item, %{content_type: record.content_type, content_json: record.content_json, txid: record.txid})
        end)

        {:ok, result}
  
      {:error, %HTTPoison.Error{reason: reason}} ->
  
        IO.inspect reason
  
        {:error, reason}
  
    end

  end

  def top_content :all, timestamp do
    IO.puts "https://pow.co/node/v1/ranking?from_timestamp=#{timestamp}"

    case HTTPoison.get("https://pow.co/node/v1/ranking?from_timestamp=#{timestamp}") do
  
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->

        result = Jason.decode!(body)["content"]

        result = Enum.map(result, fn (item) ->

          txid = item["content"]

          record = Repo.one!(from Content, where: [txid: ^txid])

          Map.merge(item, %{content_type: record.content_type, content_json: record.content_json, txid: record.txid})
        end)

        {:ok, result}
  
      {:error, %HTTPoison.Error{reason: reason}} ->
  
        IO.inspect reason
  
        {:error, reason}
  
    end

  end

  def top_content(:text) do

    case HTTPoison.get("https://pow.co/node/v1/ranking/value?limit=1000&offset=0&content_category=text") do
  
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->

        result = Jason.decode!(body)["content"]

        {:ok, result}
  
      {:error, %HTTPoison.Error{reason: reason}} ->
  
        IO.inspect reason
  
        {:error, reason}
  
    end

  end

end
