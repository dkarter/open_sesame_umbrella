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
    {:ok, %{gpio_pid: init_gpio(), status: true}}
  end

  def handle_call(:status, _from, state) do
    {:reply, !state[:status], state}
  end

  def handle_call(:toggle, _from, state) do
    new_state = toggle_status(state)
    update_relay_pin_status(new_state)
    {:reply, !new_state[:status], new_state}
  end

  # ===================================

  defp init_gpio do
    {:ok, pid} = GPIO.start_link(@pin, :output)
    # must start with off status which is "true"
    GPIO.write(pid, true)
    pid
  end

  defp toggle_status(state = %{status: status}) do
    %{state | status: !status}
  end

  defp update_relay_pin_status(%{gpio_pid: gpio_pid, status: status}) do
    GPIO.write(gpio_pid, status)
  end
end
