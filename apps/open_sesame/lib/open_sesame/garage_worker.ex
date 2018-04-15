defmodule OpenSesame.GarageWorker do
  require Logger
  use GenServer

  alias ElixirALE.GPIO

  @pin 18

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    :global.register_name(:garage_worker, self())
    {:ok, %{gpio_pid: init_gpio()}}
  end

  def handle_cast(:toggle, state) do
    update_relay_pin_status(state)
    {:noreply, state}
  end

  # ===================================

  defp init_gpio do
    {:ok, pid} = GPIO.start_link(@pin, :output)
    # must start with off status which is "true"
    GPIO.write(pid, true)
    pid
  end

  defp update_relay_pin_status(%{gpio_pid: gpio_pid}) do
    GPIO.write(gpio_pid, false)
    Process.sleep(1000)
    GPIO.write(gpio_pid, true)
  end
end
