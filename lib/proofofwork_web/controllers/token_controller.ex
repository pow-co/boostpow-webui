
defmodule ProofofworkWeb.TokenController do

  use ProofofworkWeb, :controller

   #plug :put_layout, "content.html"

  def index(conn, _params) do

      render(conn, "index.html")

  end

end
