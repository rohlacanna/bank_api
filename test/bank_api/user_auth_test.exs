defmodule BankApi.UserAuthTest do
  use BankApi.DataCase

  alias BankApi.UserAuth

  describe "users" do
    alias BankApi.UserAuth.User

    import BankApi.Factory

    @invalid_attrs %{email: nil, name: nil, password_hash: nil}

    test "list_users/0 returns all users" do
      user = insert(:user)
      assert UserAuth.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = insert(:user)
      assert UserAuth.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{email: "romulo@tomate.com", name: "Rômulo Silva", password_hash: ""}

      assert {:ok, %User{} = user} = UserAuth.create_user(valid_attrs)
      assert user.email == "romulo@tomate.com"
      assert user.name == "Rômulo Silva"
      assert user.password_hash == ""
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserAuth.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = insert(:user)

      update_attrs = %{
        email: "romulo_silva@tomate.com",
        name: "Rômulo"
      }

      assert {:ok, %User{} = user} = UserAuth.update_user(user, update_attrs)
      assert user.email == "romulo_silva@tomate.com"
      assert user.name == "Rômulo"
      assert user.password_hash == ""
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = insert(:user)
      assert {:error, %Ecto.Changeset{}} = UserAuth.update_user(user, @invalid_attrs)
      assert user == UserAuth.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = insert(:user)
      assert {:ok, %User{}} = UserAuth.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> UserAuth.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = insert(:user)
      assert %Ecto.Changeset{} = UserAuth.change_user(user)
    end
  end
end
