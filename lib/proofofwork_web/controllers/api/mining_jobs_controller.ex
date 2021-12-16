import Ecto.Query

defmodule ProofofworkWeb.Api.MiningJobsController do
  use ProofofworkWeb, :controller
  alias Proofofwork.Repo
  alias Proofofwork.BoostJob

  def index(conn, _params) do

    # get one or more new unmined jobs based on certain criteria
    # optional parameters:
    # - max_difficulty
    # - min_difficulty
    # - min_reward
    # - min_difficulty_reward_ration
    # - 

    query = from BoostJob,
      where: [spent: false],
      limit: 25,
      order_by: [asc: :difficulty]

    jobs = Repo.all(query)

    json(conn, %{jobs: jobs})

  end

end
