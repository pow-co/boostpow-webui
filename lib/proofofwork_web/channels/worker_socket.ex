defmodule ProofofworkWeb.WorkerSocket do
  use Phoenix.Socket

  ## Channels
  channel "cpuworkers:*", ProofofworkWeb.CpuWorkerChannel
  #
  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #   {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error`.
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.
  defoverridable init: 1

  @impl true
  def init(state) do
    res = {:ok, {_, socket}} = super(state)
    #on_connect(self(), socket.assigns.user_id)
    on_connect(self())
    res
  end

  def on_connect(pid) do
    # Log user_id connected, increase gauge, etc.
    monitor(pid)
  end

  defp monitor(pid) do
    Task.Supervisor.start_child(Proofofwork.TaskSupervisor, fn ->
      Process.flag(:trap_exit, true)
      ref = Process.monitor(pid)

      receive do
        {:DOWN, ^ref, :process, _pid, _reason} ->
          #on_disconnect(user_id)
          on_disconnect()
      end
    end)
  end

  @impl true
  def connect(_params, socket, _connect_info) do
    {:ok, socket} 
  end

  @impl true
  def on_disconnect do
    IO.puts "DISCONNECTED"

    {:ok} 
  end

  # Socket id's are topics that allow you to identify
  # all sockets for a given user:
  #
  #   def id(socket), do "user_socket:#{socket.assigns.user_id}"
  #
  # Would all you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #   ProofofworkWeb.Endpoint.broadcast("user_socket:#{user.id}",
  #     "disconnect", %{})
  #
  # Returning `nil` makes this socket anonmymous
  @impl true
  def id(_socket), do: nil
end
