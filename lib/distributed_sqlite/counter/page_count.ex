defmodule DistributedSqlite.Counter.PageCount do
  use Ecto.Schema
  import Ecto.Changeset

  schema "page_counts" do
    field :count, :integer
    field :page, :string

    timestamps()
  end

  @doc false
  def changeset(page_count, attrs) do
    page_count
    |> cast(attrs, [:page, :count])
    |> validate_required([:page, :count])
  end
end
