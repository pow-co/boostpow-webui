require AMQP

defmodule ProofofworkWeb.CpuWorkerChannel do

  use ProofofworkWeb, :channel
  alias Proofofwork.Repo
  alias Proofofwork.BestHash
  alias Proofofwork.Solution
  alias Proofofwork.Hashrate

  @impl true
  def join("cpuworkers:jobs", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  def handle_in("besthash", payload, socket) do

    {hashes, _} = Integer.parse(payload["hashes"])
    
    {:ok, _updated } = Repo.insert(%BestHash{
      besthash: payload["besthash"],
      publickey: payload["publickey"],
      hashes: hashes,
      difficulty: payload["difficulty"],
      content: payload["content"],
      os: payload["os"],
      ipv4: payload["ipv4"]
    })

    {:reply, {:ok, payload}, socket}
  end

  def handle_in("solution", payload, socket) do

    {:ok, _updated } = Repo.insert(%Solution{
      publickey: payload["publickey"],
      solution: payload["solution"],
      difficulty: payload["difficulty"],
      content: payload["content"],
      os: payload["os"],
      ipv4: payload["ipv4"]
    })

    {:reply, {:ok, payload}, socket}
  end

  def handle_in("hashrate", payload, socket) do

    {:ok, _updated } = Repo.insert(%Hashrate{
      publickey: payload["publickey"],
      hashrate: payload["hashrate"],
      difficulty: payload["difficulty"],
      content: payload["content"],
      ipv4: payload["ipv4"]
    })

    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (cpu_worker:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
