import Ecto.Query

defmodule ProofofworkWeb.PageController do
  use ProofofworkWeb, :controller
  alias Proofofwork.Repo
  alias Proofofwork.PlanariaRecord

  def index(conn, _params) do
    query = from PlanariaRecord, limit: 25
    planarias = Repo.all(query)
    render(conn, "index.html", planarias: planarias)
  end
end
