defmodule BankApiWeb.UserAuth.EnsureAuthenticated do
  @moduledoc """
  Ensuer the user is authenticated.
  """

  use Guardian.Plug.Pipeline,
    otp_app: :bank_api,
    error_handler: BankApiWeb.UserAuth.ErrorHandler,
    module: BankApiWeb.UserAuth.Guardian

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, allow_blank: true
end
