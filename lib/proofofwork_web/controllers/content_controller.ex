import Ecto.Query

#Example Files
#{
#  "imageContent": "1cbf1cb5b6c1b72600da298a9c116cb262649ae53db380853508ca2d0bc94b64",
#  "videoContent": "1e1c7c06786d4e7979aaaa0f6c9204910cba288741bfa8b95b43027d698e2f90",
#  "pdfContent": "4a01a98748fa64db82ff45ce58d55a0c9511fa417110aebe3c33d6221c3b07c0",
#  "markdownContent": "a1ef1e13a09b1f58c5ce7e42f7e24c02c529baa4608652b9895d10b25bb30f5a",
#  "textContent": "2829b4df5152fb867128f0ea2cffdfe3b7134a98b356eb1a1813b68fd3b83519"
#}
#*/

defmodule ProofofworkWeb.ContentController do
  use ProofofworkWeb, :controller
  alias Proofofwork.Repo
  alias Proofofwork.Ranking
  alias Proofofwork.BoostJob
  alias Proofofwork.Content
  alias Proofofwork.ContentCache
  alias Proofofwork.Boost.JobProof

   #plug :put_layout, "content.html"

  def show(conn, %{"txid" => txid} = params) do

    content = ContentCache.fetch txid

    tab = if String.match?(current_path(conn), ~r/pending$/),
      do: "pending", else: "work"

    work_query = from JobProof,
      where: [content: ^txid],
      order_by: [desc: :timestamp]

    work = Repo.all(work_query)

    jobs_query = from BoostJob,
      where: [content: ^txid],
      order_by: [desc: :timestamp]

    jobs = Repo.all(jobs_query)

    pending_jobs_query = from BoostJob,
      where: [content: ^txid, spent: false],
      order_by: [desc: :timestamp]

    pending_jobs = Repo.all(pending_jobs_query)

      render(conn, "show.html", content: content, work: work, jobs: jobs, pending_jobs: pending_jobs, tab: tab, do_boost: params["boost"])
  end

  def index(conn, _params) do

    {:ok, content} = Ranking.top_content :all

    time_filters = get_filters conn.request_path

    render(conn, "index.html", content: content, time_filters: time_filters)

  end

  def last_hour(conn, _params) do

    date = Timex.shift(Timex.now(), hours: 1) |> DateTime.to_unix

    {:ok, content} = Ranking.top_content :all, date
    content = []

    time_filters = get_filters conn.request_path

    render(conn, "index.html", content: content, time_filters: time_filters)
  end

  def last_day(conn, _params) do

    date = Timex.shift(Timex.now(), days: -1) |> DateTime.to_unix

    {:ok, content} = Ranking.top_content :all, date

    time_filters = get_filters conn.request_path

    render(conn, "index.html", content: content, time_filters: time_filters)
  end

  def last_week(conn, _params) do

    date = Timex.shift(Timex.now(), days: -7) |> DateTime.to_unix

    {:ok, content} = Ranking.top_content :all, date

    time_filters = get_filters conn.request_path

    render(conn, "index.html", content: content, time_filters: time_filters)
  end

  def last_month(conn, _params) do

    date = Timex.shift(Timex.now(), months: -1) |> DateTime.to_unix

    {:ok, content} = Ranking.top_content :all, date

    time_filters = get_filters conn.request_path

    render(conn, "index.html", content: content, time_filters: time_filters)
  end

  def last_year(conn, _params) do

    date = Timex.shift(Timex.now(), years: -1) |> DateTime.to_unix

    {:ok, content} = Ranking.top_content :all, date

    time_filters = get_filters conn.request_path

    render(conn, "index.html", content: content, time_filters: time_filters)
  end

  def all_time(conn, _params) do

    {:ok, content} = Ranking.top_content :all

    time_filters = get_filters conn.request_path

    render(conn, "index.html", content: content, time_filters: time_filters)
  end

  def text(conn, _params) do

    {:ok, content} = Ranking.top_content :text

    render(conn, "index.html", content: content)

  end

  def images(conn, _params) do

    {:ok, content} = Ranking.top_content :image

    render(conn, "index.html", content: content)

  end


  defp get_content_type txid do
   
    case HTTPoison.head("https://media.bitcoinfiles.org/#{txid}") do
  
      {:ok, %HTTPoison.Response{status_code: 200, headers: headers}} ->
  
        header = Enum.find(headers, fn(element) ->
          match?({"Content-Type", _}, element)
        end)

        type = elem(header, 1)

        [first, _] = String.split(type, "/")

        content_type = if first == "image" do
          "image"
        else
          type
        end

        {:ok,  type}

      {:ok, %HTTPoison.Response{status_code: 500, body: body}} ->

        {:error, body}
 
      {:error, %HTTPoison.Error{reason: reason}} ->
  
        IO.inspect reason
  
        {:error, reason}
  
    end
  end

  defp get_filters path do
    [
      %{:path => "/last-hour", title: "Hour"},
      %{:path => "/last-day", title: "Day"},
      %{:path => "/last-week", title: "Week"},
      %{:path => "/last-month", title: "Month"},
      %{:path => "/last-year", title: "Year"},
      %{:path => "/all-time", title: "All Time"}
    ] |> Enum.map(fn (item) ->
      if item.path == path do
          %{:path => item[:path], title: item[:title], current: true}
      else
          %{:path => item[:path], title: item[:title], current: false}
      end
    end)

  end

end

