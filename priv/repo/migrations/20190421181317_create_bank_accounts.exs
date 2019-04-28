defmodule MyexpensesPhx.Repo.Migrations.CreateBankAccounts do
  use Ecto.Migration

  def change do
    create table(:bank_accounts) do
      add :name, :string
      add :user_id, :integer

      timestamps()
    end

  end
end
