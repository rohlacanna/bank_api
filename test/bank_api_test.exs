defmodule BankApi.BankApiTest do
  use BankApi.DataCase

  alias BankApi.Banking.Account
  alias BankApi.Users.User

  describe "BankApi" do
    test "register_user_and_account/1 with valid data creates an user and it account" do
      valid_params = valid_user_params()

      assert {:ok, %{user: user, account: account}} =
               BankApi.register_user_and_account(valid_params)

      assert %User{id: id} = user
      assert %Account{user_id: ^id} = account
    end

    @invalid_attrs %{}
    test "register_user_and_account/1 with invalid data returns error changeset" do
      assert {:error, :user, %Ecto.Changeset{} = changeset, _} =
               BankApi.register_user_and_account(@invalid_attrs)

      assert errors_on(changeset) == %{
               email: ["can't be blank"],
               name: ["can't be blank"],
               password: ["can't be blank"]
             }
    end
  end
end
