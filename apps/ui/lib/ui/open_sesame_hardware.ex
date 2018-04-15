defmodule Ui.OpenSesameHardware do
  def toggle_door do
    GenServer.cast(pid(), :toggle)
  end

  defp pid do
    :global.whereis_name(:garage_worker)
  end
end
