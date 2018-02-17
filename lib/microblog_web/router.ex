defmodule MicroblogWeb.Router do
  use MicroblogWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])

    # parses the cookie header( serialized map, cryptographically signed, deserialize it and decrypt it)
    plug(:fetch_session)
    plug(:get_current_user)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  def get_current_user(conn, params) do
    # TODO: get this function out of the router
    # it doesn't belong here.
    user_id = get_session(conn, :user_id)

    if user_id do
      user = Microblog.Accounts.get_user!(user_id)
      assign(conn, :current_user, user)
    else
      assign(conn, :current_user, nil)
    end
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", MicroblogWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    get("/feed", PageController, :feed)

    resources("/users", UserController)
    resources("/posts", PostController)

    post("/session", SessionController, :create)
    delete("/session", SessionController, :delete)
  end

  # Other scopes may use custom stacks.
  # scope "/api", MicroblogWeb do
  #   pipe_through :api
  # end
end
