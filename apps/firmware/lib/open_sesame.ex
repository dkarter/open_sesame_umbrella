defmodule OpenSesame do
  alias OpenSesame.GarageWorker

  def toggle_door do
    GenServer.cast(GarageWorker, :toggle)
  end
end
