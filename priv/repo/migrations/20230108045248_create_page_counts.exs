defmodule DistributedSqlite.Repo.Migrations.CreatePageCounts do
  use Ecto.Migration

  def change do
    create table(:page_counts) do
      add :page, :string
      add :count, :integer

      timestamps()
    end
  end
end
