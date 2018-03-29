defmodule UiWeb.PageController do
  use UiWeb, :controller

  alias Ui.OpenSesameHardware

  def index(conn, _params) do
    status = OpenSesameHardware.door_status()

    render(conn, "index.html", status: status)
  end
end
