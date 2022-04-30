defmodule BankApi.Repo.Migrations.CreateUsers do
  @moduledoc false

  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :email, :string
      add :password_hash, :string

      timestamps()
    end

    create index("users", [:email], unique: true)
  end
end
