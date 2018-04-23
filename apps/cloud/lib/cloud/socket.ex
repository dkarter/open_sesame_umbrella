defmodule Cloud.Socket do
  use PhoenixChannelClient.Socket, otp_app: :cloud

  def init(args) do
    {:ok, args}
  end
end
