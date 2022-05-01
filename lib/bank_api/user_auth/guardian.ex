defmodule BankApi.UserAuth.Guardian do
  @moduledoc false

  use Guardian, otp_app: :bank_api

  alias BankApi.UserAuth

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    user = UserAuth.get_user!(id)
    {:ok, user}
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
  end
end
