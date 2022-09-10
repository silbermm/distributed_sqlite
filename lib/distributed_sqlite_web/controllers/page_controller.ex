defmodule DistributedSqliteWeb.PageController do
  use DistributedSqliteWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
