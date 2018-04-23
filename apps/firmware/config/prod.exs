use Mix.Config

config :logger, backends: [RingLogger]
config :logger, RingLogger, max_size: 100
