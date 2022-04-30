defmodule BankApiWeb.PageController do
  use BankApiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
