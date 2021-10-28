defmodule ProofofworkWeb.CpuWorkerChannelTest do
  use ProofofworkWeb.ChannelCase

  setup do
    {:ok, _, socket} =
      ProofofworkWeb.UserSocket
      |> socket("user_id", %{some: :assign})
      |> subscribe_and_join(ProofofworkWeb.CpuWorkerChannel, "cpu_worker:lobby")

    %{socket: socket}
  end

end
