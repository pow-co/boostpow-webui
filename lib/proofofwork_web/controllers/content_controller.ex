
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

   #plug :put_layout, "content.html"

  def show(conn, %{"txid" => txid}) do
    content = txid

    type = get_content_type txid

    render(conn, "show.html", content: content, content_type: type)
  end

  def index(conn, _params) do

    {:ok, content} = get_top_content

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

  defp get_top_content do
   
    case HTTPoison.get("https://pow.co/node/v1/ranking/value?limit=1000&offset=0&content_category=image") do
  
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->

        result = Jason.decode!(body)["content"]

        {:ok, result}
  
      {:error, %HTTPoison.Error{reason: reason}} ->
  
        IO.inspect reason
  
        {:error, reason}
  
    end
  end

end
