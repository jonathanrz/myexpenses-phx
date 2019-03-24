defmodule MyexpensesPhx.Users do
  import Ecto.Query, warn: false
  alias MyexpensesPhx.Repo
  alias MyexpensesPhx.User

  def get_user!(email), do: Repo.one(from u in User, where: u.email == ^email)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end