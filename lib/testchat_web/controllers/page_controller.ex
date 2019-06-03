defmodule TestchatWeb.PageController do
  use TestchatWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
