# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :cloud, Cloud.Socket,
  url: "ws://iot.doriankarter.com/socket/websocket",
  serializer: Poison

config :cloud, :app_name, "default_app"

config :logger,
  level: :debug,
  backends: [:console]
