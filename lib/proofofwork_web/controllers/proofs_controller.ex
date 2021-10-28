import Ecto.Query

defmodule ProofofworkWeb.ProofsController do
  use ProofofworkWeb, :controller
  alias Proofofwork.Repo
  alias Proofofwork.PlanariaRecord

  def index(conn, _params) do
    query = from PlanariaRecord,
      limit: 25,
      order_by: [desc: :inserted_at]

    planarias = Repo.all(query)
    render(conn, "index.html", planarias: planarias)
  end
end
