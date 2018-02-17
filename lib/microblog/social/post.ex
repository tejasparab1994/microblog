defmodule Microblog.Social.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Social.Post

  schema "posts" do
    field(:body, :string)
    # (who is the user associated with this post)
    belongs_to(:user, Microblog.Accounts.User)

    timestamps()
  end

  @doc false
  # function that is called when we try entering a post in db
  def changeset(%Post{} = post, attrs) do
    # datatypes of fields match
    # validation
    post
    |> cast(attrs, [:body, :user_id])
    |> validate_required([:body, :user_id])
  end
end
