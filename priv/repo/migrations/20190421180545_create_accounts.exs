defmodule MyexpensesPhx.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :name, :string
      add :user_id, :integer

      timestamps()
    end

  end
end
