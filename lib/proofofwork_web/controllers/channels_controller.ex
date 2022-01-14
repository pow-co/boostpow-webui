
defmodule ProofofworkWeb.ChannelsController do
  use ProofofworkWeb, :controller
  alias Proofofwork.Repo

  def show(conn, %{"channel" => channel}) do

    render(conn, "show.html", channel: channel)
  end

end

