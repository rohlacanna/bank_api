defmodule BankApi.Factory do
  # with Ecto
  use ExMachina.Ecto, repo: BankApi.Repo

  import Faker.Person.PtBr, only: [name: 0]

  alias BankApi.UserAuth.User

  def user_factory do
    %User{
      name: name(),
      email: sequence(:email, &"email-#{&1}@example.com"),
      password_hash: ""
    }
  end
end
