defmodule Proofofwork.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    Dotenv.load

    children = [
      # Start the Ecto repository
      Proofofwork.Repo,
      # Start the Telemetry supervisor
      ProofofworkWeb.Telemetry,

      {Task.Supervisor, name: Proofofwork.TaskSupervisor},
      # Start the PubSub system
      {Phoenix.PubSub, name: Proofofwork.PubSub},
      # Start the Endpoint (http/https)
      ProofofworkWeb.Endpoint
      # Start a worker by calling: Proofofwork.Worker.start_link(arg)
      # {Proofofwork.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Proofofwork.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ProofofworkWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
