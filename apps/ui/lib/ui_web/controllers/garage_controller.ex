defmodule UiWeb.GarageController do
  use UiWeb, :controller

  alias Ui.OpenSesameHardware

  def toggle(conn, _params) do
    status = OpenSesameHardware.toggle_door()

    conn
    |> put_view(UiWeb.PageView)
    |> render("index.html", status: status)
  end
end
