defmodule ProofofworkWeb.PageController do
  use ProofofworkWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
