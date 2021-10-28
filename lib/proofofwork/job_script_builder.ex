defmodule Proofofwork.JobScriptBuilder do

  def build_script(content, difficulty) do

    headers = [
      {"Content-Type", "application/json"}
    ]

    json = Jason.encode!(%{"content": content, "difficulty": difficulty})

    service_host = System.get_env("NODE_API_BASE")

    IO.inspect service_host

    case HTTPoison.post("#{service_host}/node/api/boost_jobs", json, headers) do

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
