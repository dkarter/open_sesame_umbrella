defmodule Cloud do
  alias Cloud.{Notifier, Logger}

  # @doc """
  # Sends a notification to the server to the server.

  # A notification can be something such as :door_closed which can then be used by the server to send push notifications for example.
  # """
  # def notify(notification) do
  #   Notifier.Client.push(notification)
  # end

  @doc """
  Submits log data to the server.

  Log data should probably be a map, but that is entirely up to the server consuming the messages
  """
  def submit_log(log_data) do
    Logger.Client.submit_log(log_data)
  end
end
