defmodule Proofofwork.JobScriptBuilder do

  def build_script(content, difficulty) do

    headers = [
      {"Content-Type", "application/json"}
    ]

    json = Jason.encode!(%{"content": content, "difficulty": difficulty})

    service_host = "http://127.0.0.1:4001"

    case HTTPoison.post("#{service_host}/boost_jobs", json, headers) do

      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->

        newjob = Jason.decode!(body)

        {:ok, newjob}

      {:ok, %HTTPoison.Response{status_code: 500, body: body}} ->
        IO.inspect body

        {:error, body}

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason

        {:error, reason}
    end

  end

end
