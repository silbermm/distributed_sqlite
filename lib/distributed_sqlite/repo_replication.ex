# /lib/distributed_sqlite/repo_replication.ex
defmodule DistributedSqlite.RepoReplication do
  @moduledoc """
  Run on each node to handle replicating Repo writes
  """
  use GenServer

  alias DistributedSqlite.Repo

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  @impl true
  def init(_args) do
    {:ok, []}
  end

  @impl true
  def handle_cast({:replicate, query, :insert}, state) do
    Repo.insert!(query)
    {:noreply, state}
  end

  def handle_cast({:replicate, changeset, :update}, state) do
    Repo.update!(changeset)
    {:noreply, state}
  end
end
