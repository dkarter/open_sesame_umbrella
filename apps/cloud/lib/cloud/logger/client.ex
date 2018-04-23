defmodule Cloud.Logger.Client do
  use GenServer

  alias Cloud.Logger.Channel

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    Channel.join_app()
    {:ok, %{}}
  end

  def submit_log(log_data) do
    Channel.submit_log(log_data)
  end
end
