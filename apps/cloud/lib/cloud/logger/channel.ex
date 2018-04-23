defmodule Cloud.Logger.Channel do
  use PhoenixChannelClient
  require Logger

  alias Cloud.Socket

  @app_name Application.get_env(:cloud, :app_name)

  def join_app(app_name \\ @app_name) do
    Logger.debug("joining #{app_name} to logger")
    topic = "logger:#{app_name}"

    with {:ok, _channel} <- PhoenixChannelClient.channel(__MODULE__, socket: Socket, topic: topic) do
      join(%{})
    else
      {:error, error} -> Logger.error(error)
    end
  end

  def submit_log(log_data) do
    push("new:log", log_data)
  end

  def handle_reply({:ok, :join, _resp, _ref}, state) do
    Logger.debug("==== join logger channel success")
    {:noreply, state}
  end

  def handle_reply({:error, :join, _resp, _ref}, state) do
    Logger.error("==== cannot join logger channel")
    {:noreply, state}
  end

  def handle_reply({:timeout, :join, _ref}, state) do
    Logger.error("got timeout trying to join logger channel")
    {:noreply, state}
  end

  def handle_reply({:timeout, msg, _ref}, state) do
    Logger.info("Cloud.Logger.Channel got timeout for #{msg}")
    {:noreply, state}
  end

  # def handle_close(reason, state) do
  #   Logger.info("closed: #{reason}")
  #   send_after(5000, :rejoin)
  #   {:noreply, rejoin(state)}
  # end
end
