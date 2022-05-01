defmodule BankApi.UserAuth.Pipeline do
  @moduledoc false

  use Guardian.Plug.Pipeline,
    otp_app: :bank_api,
    error_handler: BankApi.UserAuth.ErrorHandler,
    module: BankApi.UserAuth.Guardian

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true
end
