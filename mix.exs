defmodule Statsy.MixProject do
  use Mix.Project

  def project do
    [
      app: :statsy,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :cowboy, :plug],
      mod: { Statsy, [] }
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:slack, "~> 0.14.0"},
      {:cowboy, "~> 2.4.0"},
      {:plug, "~> 1.6.3"}
    ]
  end
end
