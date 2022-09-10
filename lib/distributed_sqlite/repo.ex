defmodule DistributedSqlite.Repo do
  use Ecto.Repo,
    otp_app: :distributed_sqlite,
    adapter: Ecto.Adapters.SQLite3
end
