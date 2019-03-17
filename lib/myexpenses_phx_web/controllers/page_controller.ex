defmodule MyexpensesPhxWeb.PageController do
  use MyexpensesPhxWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
