defmodule MyexpensesPhx.DataTest do
  use MyexpensesPhx.DataCase

  alias MyexpensesPhx.Data

  describe "bank_accounts" do
    alias MyexpensesPhx.Data.BankAccount

    @valid_attrs %{name: "some name", user_id: 42}
    @update_attrs %{name: "some updated name", user_id: 43}
    @invalid_attrs %{name: nil, user_id: nil}

    def bank_account_fixture(attrs \\ %{}) do
      {:ok, bank_account} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Data.create_bank_account()

      bank_account
    end

    test "list_bank_accounts/0 returns all bank_accounts" do
      bank_account = bank_account_fixture()
      assert Data.list_bank_accounts() == [bank_account]
    end

    test "get_bank_account!/1 returns the bank_account with given id" do
      bank_account = bank_account_fixture()
      assert Data.get_bank_account!(bank_account.id) == bank_account
    end

    test "create_bank_account/1 with valid data creates a bank_account" do
      assert {:ok, %BankAccount{} = bank_account} = Data.create_bank_account(@valid_attrs)
      assert bank_account.name == "some name"
      assert bank_account.user_id == 42
    end

    test "create_bank_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Data.create_bank_account(@invalid_attrs)
    end

    test "update_bank_account/2 with valid data updates the bank_account" do
      bank_account = bank_account_fixture()
      assert {:ok, %BankAccount{} = bank_account} = Data.update_bank_account(bank_account, @update_attrs)
      assert bank_account.name == "some updated name"
      assert bank_account.user_id == 43
    end

    test "update_bank_account/2 with invalid data returns error changeset" do
      bank_account = bank_account_fixture()
      assert {:error, %Ecto.Changeset{}} = Data.update_bank_account(bank_account, @invalid_attrs)
      assert bank_account == Data.get_bank_account!(bank_account.id)
    end

    test "delete_bank_account/1 deletes the bank_account" do
      bank_account = bank_account_fixture()
      assert {:ok, %BankAccount{}} = Data.delete_bank_account(bank_account)
      assert_raise Ecto.NoResultsError, fn -> Data.get_bank_account!(bank_account.id) end
    end

    test "change_bank_account/1 returns a bank_account changeset" do
      bank_account = bank_account_fixture()
      assert %Ecto.Changeset{} = Data.change_bank_account(bank_account)
    end
  end
end
