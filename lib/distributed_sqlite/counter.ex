# lib/distributed_sqlite/counter.ex
defmodule DistributedSqlite.Counter do
  alias DistributedSqlite.Counter.PageCount
  alias DistributedSqlite.Repo

  def count_page_view(page_name) do
    page_count = Repo.get_by(PageCount, page: page_name) || %PageCount{page: page_name, count: 0}

    page_count
    |> PageCount.changeset(%{count: page_count.count + 1})
    |> Repo.insert_or_update!()
  end
end
