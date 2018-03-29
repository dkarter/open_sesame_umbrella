defmodule OpenSesame do
  alias OpenSesame.GarageWorker

  def toggle_door do
    GenServer.call(GarageWorker, :toggle, [])
  end

  def door_status do
    GenServer.call(GarageWorker, :status, [])
  end
end
