defmodule OpenSesame.MixProject do
  use Mix.Project

  @target System.get_env("MIX_TARGET") || "host"

  def project do
    [
      app: :open_sesame,
      version: "0.1.0",
      elixir: "~> 1.6",
      target: @target,
      archives: [nerves_bootstrap: "~> 1.0-rc"],
      build_path: "../../_build/#{@target}",
      config_path: "../../config/config.exs",
      deps_path: "../../deps/#{@target}",
      lockfile: "../../mix.lock.#{@target}",
      start_permanent: Mix.env() == :prod,
      aliases: [loadconfig: [&bootstrap/1]],
      deps: deps()
    ]
  end

  # Starting nerves_bootstrap adds the required aliases to Mix.Project.config()
  # Aliases are only added if MIX_TARGET is set.
  def bootstrap(args) do
    Application.start(:nerves_bootstrap)
    Mix.Task.run("loadconfig", args)
  end

  # Run "mix help compile.app" to learn about applications.
  def application, do: application(@target)

  # Specify target specific application configurations
  # It is common that the application start function will start and supervise
  # applications which could cause the host to fail. Because of this, we only
  # invoke OpenSesame.start/2 when running on a target.
  def application("host") do
    [extra_applications: [:logger]]
  end

  def application(_target) do
    [
      mod: {OpenSesame.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nerves, "~> 1.0-rc", runtime: false},
      {:ui, in_umbrella: true},
      {:cloud, in_umbrella: true}
    ] ++ deps(@target)
  end

  # Specify target specific dependencies
  defp deps("host"), do: []

  defp deps(target) do
    [
      {:shoehorn, "~> 0.2"},
      {:nerves_runtime, "~> 0.4"},
      {:nerves_init_gadget, "~> 0.3.0"},
      {:nerves_firmware_ssh, "~> 0.3.2"},
      {:elixir_ale, "~> 1.0.3"}
    ] ++ system(target)
  end

  defp system("rpi0") do
    [{:nerves_system_rpi0, "~> 1.0-rc", runtime: false}]
  end

  defp system("rpi") do
    [{:nerves_system_rpi, "~> 1.0-rc", runtime: false}]
  end

  defp system(target) do
    Mix.raise("Unknown MIX_TARGET: #{target}")
  end
end
