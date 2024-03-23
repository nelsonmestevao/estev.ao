defmodule Estevao.MixProject do
  use Mix.Project

  @app :estevao
  @name "estev.ao"
  @version "1.0.0"
  @description "A short and simple redirecting service"

  def project do
    [
      app: @app,
      name: @name,
      version: @version,
      description: @description,
      homepage_url: "https://estev.ao",
      elixir: "~> 1.11",
      elixirc_paths: elixirc_paths(Mix.env()),
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
      extra_applications: [:logger, :runtime_tools, :os_mon]
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
      {:phoenix, "~> 1.7.11"},
      {:phoenix_html, "~> 4.1"},
      {:phoenix_live_view, "~> 0.20.1"},
      {:bandit, "~> 1.2"},

      # graphql
      {:absinthe, "~> 1.7"},
      {:absinthe_plug, "~> 1.5"},

      # database
      {:phoenix_ecto, "~> 4.4"},
      {:ecto_sql, "~> 3.10"},
      {:postgrex, ">= 0.0.0"},

      # mailer
      {:swoosh, "~> 1.3"},
      {:finch, "~> 0.13"},

      # i18n
      {:gettext, "~> 0.20"},

      # utilities
      {:jason, "~> 1.2"},
      {:nanoid, "~> 2.1.0"},
      {:utilx, "~> 0.4.0"},

      # clustering
      {:dns_cluster, "~> 0.1.1"},

      # monitoring
      {:telemetry_metrics, "~> 1.0"},
      {:telemetry_poller, "~> 1.0"},
      {:phoenix_live_dashboard, "~> 0.8.2"},
      {:ecto_psql_extras, "~> 0.7.12"},

      # assets
      {:esbuild, "~> 0.8", runtime: Mix.env() == :dev},
      {:tailwind, "~> 0.2.0", runtime: Mix.env() == :dev},
      {:heroicons, github: "tailwindlabs/heroicons", tag: "v2.1.1", sparse: "optimized", app: false, compile: false, depth: 1},

      # development
      {:phoenix_live_reload, "~> 1.2", only: :dev},

      # testing
      {:floki, ">= 0.30.0", only: :test},

      # tools
      {:styler, "~> 0.7", only: [:dev, :test], runtime: false},
      {:tailwind_formatter, "~> 0.4.0", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.3", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.30", only: :dev, runtime: false}
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
      setup: ["deps.get", "ecto.setup", "assets.setup", "assets.build"],
      "ecto.seed": ["run priv/repo/seeds.exs"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "ecto.seed"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "lint.credo": ["credo --strict --all"],
      "lint.dialyzer": ["dialyzer --format dialyxir"],
      lint: ["lint.dialyzer", "lint.credo"],
      check: [
        "clean",
        "deps.unlock --check-unused",
        "compile --warnings-as-errors",
        "format --check-formatted",
        "deps.unlock --check-unused",
        "test --warnings-as-errors",
        "credo --strict --all"
      ],
      "assets.setup": ["tailwind.install --if-missing", "esbuild.install --if-missing"],
      "assets.build": ["tailwind estevao", "esbuild estevao"],
      "assets.deploy": ["tailwind estevao --minify", "esbuild estevao --minify", "phx.digest"]
    ]
  end
end
