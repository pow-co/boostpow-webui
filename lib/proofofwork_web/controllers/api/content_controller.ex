import Ecto.Query

defmodule ProofofworkWeb.Api.ContentController do
  use ProofofworkWeb, :controller
  alias Proofofwork.Repo
  alias Proofofwork.Boost.JobProof
  alias Proofofwork.BoostJob

  def show(conn, %{"content"=>content}) do

    query = from JobProof,
      where: [
        content: ^content 
      ]

    work = Repo.all(query)

    query = from BoostJob,
      where: [
        content: ^content,
        spent: false
      ]

    jobs = Repo.all(query)

    json(conn, %{work: work, jobs: jobs})

  end
end
