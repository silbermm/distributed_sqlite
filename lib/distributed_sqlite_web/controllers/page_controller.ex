defmodule DistributedSqliteWeb.PageController do
  use DistributedSqliteWeb, :controller

  alias DistributedSqlite.Counter

  def index(conn, _params) do
    page_view = Counter.count_page_view("home")
    render(conn, "index.html", view_count: page_view.count)
  end
end
