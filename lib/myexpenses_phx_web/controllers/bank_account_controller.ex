defmodule MyexpensesPhxWeb.BankAccountController do
  use MyexpensesPhxWeb, :controller

  alias MyexpensesPhx.Data
  alias MyexpensesPhx.Data.BankAccount

  plug :secure

  defp secure(conn, _params) do
    user = get_session(conn, :current_user)
    case user do
      nil -> conn |> redirect(to: "/auth/auth0") |> halt
      _ -> conn |> assign(:current_user, user)
    end
  end

  def index(conn, _params) do
    user = get_session(conn, :current_user)
    bank_accounts = Data.list_bank_accounts(user)
    render(conn, "index.html", bank_accounts: bank_accounts)
  end

  def new(conn, _params) do
    changeset = Data.change_bank_account(%BankAccount{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"bank_account" => bank_account_params}) do
    user = get_session(conn, :current_user)
    case Data.create_bank_account(Map.put(bank_account_params, "user_id", user.id)) do
      {:ok, bank_account} ->
        conn
        |> put_flash(:info, "Bank account created successfully.")
        |> redirect(to: Routes.bank_account_path(conn, :show, bank_account))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    bank_account = Data.get_bank_account!(id)
    user = get_session(conn, :current_user)
    cond do
      bank_account.user_id == user.id -> render(conn, "show.html", bank_account: bank_account)
      true -> conn
              |> put_flash(:error, "You don't have access to this bank account.")
              |> redirect(to: Routes.bank_account_path(conn, :index))
    end
  end

  def edit(conn, %{"id" => id}) do
    bank_account = Data.get_bank_account!(id)
    user = get_session(conn, :current_user)
    cond do
      bank_account.user_id == user.id ->
        changeset = Data.change_bank_account(bank_account)
        render(conn, "edit.html", bank_account: bank_account, changeset: changeset)
      true -> conn
        |> put_flash(:error, "You don't have access to this bank account.")
        |> redirect(to: Routes.bank_account_path(conn, :index))
    end
  end

  def update(conn, %{"id" => id, "bank_account" => bank_account_params}) do
    bank_account = Data.get_bank_account!(id)

    case Data.update_bank_account(bank_account, bank_account_params) do
      {:ok, bank_account} ->
        conn
        |> put_flash(:info, "Bank account updated successfully.")
        |> redirect(to: Routes.bank_account_path(conn, :show, bank_account))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", bank_account: bank_account, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    bank_account = Data.get_bank_account!(id)
    {:ok, _bank_account} = Data.delete_bank_account(bank_account)

    conn
    |> put_flash(:info, "Bank account deleted successfully.")
    |> redirect(to: Routes.bank_account_path(conn, :index))
  end
end
