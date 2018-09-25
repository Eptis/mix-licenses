defmodule MixLicenses.MixProject do
  use Mix.Project

  def project do
    [
      app: :mix_licenses,
      version: "0.1.0",
      elixir: "~> 1.6",
      package: %{
        maintainers: ["Dennis Tel"],
        licenses: ["MIT"],
        links: %{
          github: "https://github.com/Eptis/mix-licenses"
        },
      files: ["lib/mix/tasks/licenses.ex"],

      },
      source_url: "https://github.com/Eptis/mix-licenses",
      homepage_url: "https://github.com/Eptis/mix-licenses",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: """
      Adds the task `mix deps.licenses` to your mix tasks to print out a table of your mix.lock dependencies and the license they use.
      """
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
      {:ex_doc, "~> 0.18.0", only: :dev}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end
end
