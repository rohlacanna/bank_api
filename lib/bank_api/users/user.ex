defmodule BankApi.Users.User do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string, virtual: true, redact: true
    field :password_hash, :string, redact: true

    timestamps()
  end

  @doc false
  def update_changeset(user, attrs) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  @doc false
  def registration_changeset(user, attrs) do
    user
    |> update_changeset(attrs)
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> unique_constraint([:email])
    |> validate_confirmation(:password)
    |> put_password_hash()
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
