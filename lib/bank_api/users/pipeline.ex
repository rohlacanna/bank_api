defmodule BankApi.Users.Pipeline do
  @moduledoc false

  use Guardian.Plug.Pipeline,
    otp_app: :bank_api,
    error_handler: BankApi.Users.ErrorHandler,
    module: BankApi.Users.Guardian

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true
end
