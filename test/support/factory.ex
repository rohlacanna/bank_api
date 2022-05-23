defmodule BankApi.Factory do
  @moduledoc false

  # with Ecto
  use ExMachina.Ecto, repo: BankApi.Repo

  import Faker.Person.PtBr, only: [name: 0]

  alias BankApi.Banking.Account
  alias BankApi.Users.User

  def user_factory do
    %User{
      name: name(),
      email: sequence(:email, &"email-#{&1}@example.com"),
      password_hash: ""
    }
  end

  def account_factory do
    user = insert(:user)

    %Account{
      user_id: user.id
    }
  end
end
