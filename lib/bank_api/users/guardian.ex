defmodule BankApi.Users.Guardian do
  @moduledoc false

  use Guardian, otp_app: :bank_api

  alias BankApi.Users

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    user = Users.get_user!(id)
    {:ok, user}
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
  end
end
