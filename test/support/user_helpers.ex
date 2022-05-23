defmodule BankApi.UserHelpers do
  import BankApi.Factory

  def valid_user_params(password \\ "123456") do
    :user
    |> params_for(password: password)
    |> Map.put(:password_confirmation, password)
  end
end
