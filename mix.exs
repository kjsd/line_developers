defmodule LINEDevelopers.MixProject do
  use Mix.Project

  @description"""
  This package is the LINE API SDK for elixir. https://developers.line.biz/
  """

  def project do
    [
      app: :line_developers,
      version: "0.1.3",
      elixir: "~> 1.14",
      description: @description,
      package: package(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def package do
    [
      maintainers: ["kjsd"],
      licenses: ["BSD-2-Clause license"],
      links: %{ "Github": "https://github.com/kjsd/line_developers" }
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
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:httpoison, "~> 2.1"},
      {:uuid, "~> 1.1"},
      {:jason, "~> 1.4"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
