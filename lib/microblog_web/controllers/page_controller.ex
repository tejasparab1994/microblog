defmodule MicroblogWeb.PageController do
  use MicroblogWeb, :controller

  alias Microblog.Social

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def feed(conn, _params) do
    posts = Social.list_posts()
    changeset = Social.change_post(%Social.Post{})
    render(conn, "feed.html", posts: posts, changeset: changeset)
  end
end
