defmodule Estevao.MixProject do
  use Mix.Project

  @app :estevao
  @name "estev.ao"
  @version "1.0.0-dev"
  @description "A short and simple redirecting service."

  def project do
    [
      app: @app,
      name: @name,
      version: @version,
      description: @description,
      homepage_url: "https://estev.ao",
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      preferred_cli_env: [
        check: :test
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Estevao.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # web
      {:phoenix, "~> 1.6.9"},
      {:phoenix_html, "~> 3.0"},
      {:phoenix_live_view, "~> 0.18.0"},

      # database
      {:phoenix_ecto, "~> 4.4"},
      {:ecto_sql, "~> 3.6"},
      {:postgrex, ">= 0.0.0"},

      # i18n
      {:gettext, "~> 0.18"},

      # mailer
      {:swoosh, "~> 1.3"},

      # utilities
      {:jason, "~> 1.2"},
      {:plug_cowboy, "~> 2.5"},
      {:nanoid, "~> 2.0.5"},
      {:mnemonic_slugs, "~> 0.0.3"},

      # monitoring
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:phoenix_live_dashboard, "~> 0.6"},

      # testing
      {:floki, ">= 0.30.0", only: :test},

      # development
      {:dotenvy, "~> 0.6.0", runtime: Mix.env() == :dev},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:esbuild, "~> 0.4", runtime: Mix.env() == :dev},
      {:tailwind, "~> 0.1", runtime: Mix.env() == :dev},
      {:tailwind_formatter, "~> 0.2.0"},

      # tools
      {:sobelow, "~> 0.11", only: :dev, runtime: false},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.1", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.28", only: :dev, runtime: false}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.seed": ["run priv/repo/seeds.exs"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "ecto.seed"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.deploy": ["tailwind default --minify", "esbuild default --minify", "phx.digest"],
      lint: ["credo --strict --all"],
      check: [
        "clean",
        "deps.unlock --check-unused",
        "compile --warnings-as-errors",
        "format --check-formatted",
        "deps.unlock --check-unused",
        "test --warnings-as-errors",
        "lint"
      ]
    ]
  end
end
