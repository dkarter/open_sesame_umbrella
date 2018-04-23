defmodule Cloud.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias Cloud.{Logger, Socket}

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Socket, []),
      worker(Logger.Client, [])
    ]

    opts = [strategy: :one_for_one, name: Cloud.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
