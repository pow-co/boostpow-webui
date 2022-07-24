import Ecto.Query

defmodule ProofofworkWeb.JobsController do
  use ProofofworkWeb, :controller
  alias Proofofwork.Repo
  alias Proofofwork.BoostJob

  alias Proofofwork.JobScriptBuilder

  def index(conn, _params) do
    query = from BoostJob,
      where: [spent: true],
      limit: 25,
      order_by: [desc: :inserted_at]

    jobs = Repo.all(query)
    render(conn, "index.html", jobs: jobs)
  end

  def mined(conn, _params) do

    case HTTPoison.get("https://pow.co/api/v1/boost/work") do
  
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
  
        result = Jason.decode!(body)

        IO.inspect result

        render(conn, "index.html", jobs: result["work"], mined: false, error: nil)
 
      {:ok, %HTTPoison.Response{status_code: 500, body: body}} ->
  
        error = Jason.decode!(body)#["error"]
        IO.puts "500 ERROR"

        IO.inspect error

        render(conn, "index.html", jobs: [], mined: false, error: error)
  
      {:error, %HTTPoison.Error{reason: reason}} ->

        IO.puts "UNKNOWN ERROR"
  
        IO.inspect reason

        render(conn, "index.html", jobs: [], mined: false, error: reason)
  
    end

  end

  def notmined(conn, _params) do

    case HTTPoison.get("https://pow.co/api/v1/boost/jobs") do
  
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
  
        result = Jason.decode!(body)

        IO.inspect result

        render(conn, "index.html", jobs: result["jobs"], mined: false, error: nil)
 
      {:ok, %HTTPoison.Response{status_code: 500, body: body}} ->
  
        error = Jason.decode!(body)#["error"]
        IO.puts "500 ERROR"

        IO.inspect error

        render(conn, "index.html", jobs: [], mined: false, error: error)
  
      {:error, %HTTPoison.Error{reason: reason}} ->

        IO.puts "UNKNOWN ERROR"
  
        IO.inspect reason

        render(conn, "index.html", jobs: [], mined: false, error: reason)
  
    end

  end


  def new(conn, %{"content"=>content,"difficulty"=>difficulty} = params) do

    json = Jason.encode!(%{"content": content, "difficulty": difficulty})

    {difficulty, _} =  Float.parse(difficulty)

    price = if params["price"] && params["price"] > 100 do
      if String.length(String.trim params["price"]) == 0 do
        price = 10000 * 100 * difficulty
      else
        {price, _} = Integer.parse(params["price"])
        price
      end

    else

      price = 10000 * 100 * difficulty
      price

    end

    case JobScriptBuilder.build_script(content, difficulty) do

      {:ok, newjob} ->

        render(conn, "new.html", scripthex: newjob["hex"], content: content, difficulty: difficulty, price: price)

      {:error, reason} ->

        render(conn, "new.html", error: reason)

    end


  end

  def new(conn, _params) do

    render(conn, "new.html", content: false)
  end
end
