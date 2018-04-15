defmodule UiWeb.GarageController do
  use UiWeb, :controller

  alias Ui.OpenSesameHardware

  def toggle(conn, _params) do
    OpenSesameHardware.toggle_door()

    conn
    |> put_view(UiWeb.PageView)
    |> render("index.html")
  end
end
