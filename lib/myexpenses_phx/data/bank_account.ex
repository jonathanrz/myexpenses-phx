defmodule MyexpensesPhx.Data.BankAccount do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bank_accounts" do
    field :name, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(bank_account, attrs) do
    bank_account
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name, :user_id])
  end
end
