defmodule Microblog.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    # implicit: id auto-incrementing integer
    create table(:users) do
      add(:email, :string, null: false)
      add(:name, :string, null: false)

      timestamps()
      #
    end
  end
end
