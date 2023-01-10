defmodule DistributedSqlite.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    topologies = Application.get_env(:libcluster, :topologies) || []

    children = [
      {Cluster.Supervisor, [topologies, [name: DistributedSqlite.ClusterSupervisor]]},
      # Start the Ecto repository
      DistributedSqlite.Repo,
      # Start the Telemetry supervisor
      DistributedSqliteWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: DistributedSqlite.PubSub},
      # Start the Endpoint (http/https)
      DistributedSqliteWeb.Endpoint,
      # Start a worker by calling: DistributedSqlite.Worker.start_link(arg)
      # {DistributedSqlite.Worker, arg}
      {DistributedSqlite.RepoReplication, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DistributedSqlite.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DistributedSqliteWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
