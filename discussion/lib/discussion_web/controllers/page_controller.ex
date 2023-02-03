defmodule DiscussionWeb.PageController do
  use DiscussionWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
