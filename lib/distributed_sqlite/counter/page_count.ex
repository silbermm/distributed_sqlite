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

  @doc """
  Build a changeset fit for replicating
  """
  def replicate_changeset(page_count) do
    changeset(%__MODULE__{id: page_count.id}, %{
      count: page_count.count,
      page: page_count.page
    })
  end
end
