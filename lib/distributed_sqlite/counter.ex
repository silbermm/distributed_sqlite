# lib/distributed_sqlite/counter.ex
defmodule DistributedSqlite.Counter do
  alias DistributedSqlite.Counter.PageCount
  alias DistributedSqlite.Repo

  def count_page_view(page_name) do
    page_count = Repo.get_by(PageCount, page: page_name)

    case page_count do
      nil ->
        %PageCount{}
        |> PageCount.changeset(%{count: 1, page: page_name})
        |> Repo.insert()
        |> Repo.replicate(:insert)

      %PageCount{} = page_count ->
        page_count
        |> PageCount.changeset(%{count: page_count.count + 1})
        |> Repo.update()
        |> Repo.replicate(:update)
    end
  end
end
