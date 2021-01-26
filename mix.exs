defmodule Voicehaterbot.MixProject do
  use Mix.Project

  def project do
    [
      app: :voicehaterbot,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Voicehaterbot, []},
      extra_applications: [:logger, :que]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nadia, "~> 0.7.0"},
      {:que, "~> 0.10.1"},
      {:jason, "~> 1.2"}
    ]
  end
end
