defmodule Task4CClientRobotA.MixProject do
  use Mix.Project

  def project do
    [
      app: :task_4c_client_robota,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, only: :dev, runtime: false},
      {:phoenix_client, "~> 0.3"},
      {:jason, "~> 1.1"},
      {:csv, "~> 2.4.1"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
