defmodule Ui.OpenSesameHardware do
  def toggle_door do
    GenServer.call(pid(), :toggle)
  end

  def door_status do
    GenServer.call(pid(), :status)
  end

  defp pid do
    :global.whereis_name(:garage_worker)
  end
end
