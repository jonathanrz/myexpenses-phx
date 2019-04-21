defmodule MyexpensesPhxWeb.BankAccountControllerTest do
  use MyexpensesPhxWeb.ConnCase

  alias MyexpensesPhx.Data

  @create_attrs %{name: "some name", user_id: 42}
  @update_attrs %{name: "some updated name", user_id: 43}
  @invalid_attrs %{name: nil, user_id: nil}

  def fixture(:bank_account) do
    {:ok, bank_account} = Data.create_bank_account(@create_attrs)
    bank_account
  end

  describe "index" do
    test "lists all bank_accounts", %{conn: conn} do
      conn = get(conn, Routes.bank_account_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Bank accounts"
    end
  end

  describe "new bank_account" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.bank_account_path(conn, :new))
      assert html_response(conn, 200) =~ "New Bank account"
    end
  end

  describe "create bank_account" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.bank_account_path(conn, :create), bank_account: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.bank_account_path(conn, :show, id)

      conn = get(conn, Routes.bank_account_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Bank account"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.bank_account_path(conn, :create), bank_account: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Bank account"
    end
  end

  describe "edit bank_account" do
    setup [:create_bank_account]

    test "renders form for editing chosen bank_account", %{conn: conn, bank_account: bank_account} do
      conn = get(conn, Routes.bank_account_path(conn, :edit, bank_account))
      assert html_response(conn, 200) =~ "Edit Bank account"
    end
  end

  describe "update bank_account" do
    setup [:create_bank_account]

    test "redirects when data is valid", %{conn: conn, bank_account: bank_account} do
      conn = put(conn, Routes.bank_account_path(conn, :update, bank_account), bank_account: @update_attrs)
      assert redirected_to(conn) == Routes.bank_account_path(conn, :show, bank_account)

      conn = get(conn, Routes.bank_account_path(conn, :show, bank_account))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, bank_account: bank_account} do
      conn = put(conn, Routes.bank_account_path(conn, :update, bank_account), bank_account: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Bank account"
    end
  end

  describe "delete bank_account" do
    setup [:create_bank_account]

    test "deletes chosen bank_account", %{conn: conn, bank_account: bank_account} do
      conn = delete(conn, Routes.bank_account_path(conn, :delete, bank_account))
      assert redirected_to(conn) == Routes.bank_account_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.bank_account_path(conn, :show, bank_account))
      end
    end
  end

  defp create_bank_account(_) do
    bank_account = fixture(:bank_account)
    {:ok, bank_account: bank_account}
  end
end
