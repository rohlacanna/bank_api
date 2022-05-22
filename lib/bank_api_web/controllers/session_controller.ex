defmodule BankApiWeb.SessionController do
  use BankApiWeb, :controller

  alias BankApi.Users
  alias BankApi.Users.User
  alias BankApiWeb.Auth

  action_fallback BankApiWeb.FallbackController

  def create(conn, %{"credentials" => %{"email" => email, "password" => password}}) do
    with {:ok, %User{} = user} <- Users.authenticate_user(email, password),
         {:ok, token} <- Auth.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("show.json", session: %{user: user, token: token})
    else
      {:error, :unauthorized} ->
        conn
        |> put_status(:unauthorized)
        |> render("invalid_credentials.json")

      error ->
        error
    end
  end
end
