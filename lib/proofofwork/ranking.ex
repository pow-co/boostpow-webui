
import Ecto.Query

defmodule Proofofwork.Ranking do
  alias Proofofwork.Repo
  alias Proofofwork.Content

  def top_content do

    case HTTPoison.get("https://pow.co/api/v1/boost/rankings/value?limit=1000&offset=0&content_category=image") do

      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        result = Jason.decode!(body)["content"]

        {:ok, result}

      {:error, %HTTPoison.Error{reason: reason}} ->

        IO.inspect reason

        {:error, reason}

    end

  end

  def top_content :all do

    case HTTPoison.get("https://pow.co/api/v1/boost/rankings?limit=100") do

      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->

        result = Jason.decode!(body)["rankings"]

        result = Enum.map(result, fn (item) ->

          txid = item["content"]

          item
        end)

        {:ok, result}

      {:error, %HTTPoison.Error{reason: reason}} ->

        IO.inspect reason

        {:error, reason}

    end

  end

  def top_content :all, timestamp do

    case HTTPoison.get("https://pow.co/api/v1/boost/rankings?start_date=#{timestamp}") do

      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->

        result = Jason.decode!(body)["rankings"]

        result = Enum.map(result, fn (item) ->

          txid = item["content_txid"]

          Map.merge(item, %{
            txid: txid
          })
        end)

        {:ok, result}

      {:error, %HTTPoison.Error{reason: reason}} ->

        IO.inspect reason

        {:error, reason}

    end

  end

end
