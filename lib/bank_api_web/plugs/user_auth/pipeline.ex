defmodule BankApiWeb.UserAuth.Pipeline do
  @moduledoc false

  use Guardian.Plug.Pipeline,
    otp_app: :bank_api,
    error_handler: BankApiWeb.UserAuth.ErrorHandler,
    module: BankApiWeb.UserAuth.Guardian

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, allow_blank: true
end
