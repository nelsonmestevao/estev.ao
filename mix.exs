defmodule Estevao.MixProject do
  use Mix.Project

  @version "1.0.0"
  @description "A short and simple redirecting service"

  def project do
    [
      app: :estevao,
      name: "estev.ao",
      version: @version,
      description: @description,
      homepage_url: "https://estev.ao",
      elixir: "~> 1.18",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      dialyzer: dialyzer()
    ]
  end

  def cli do
    [preferred_envs: [check: :test]]
  end

  def application do
    [
      mod: {Estevao.Application, []},
      extra_applications: [:logger, :runtime_tools, :os_mon]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp dialyzer do
    [
      list_unused_filters: true,
      plt_add_deps: :apps_tree,
      plt_add_apps: [:eex, :ex_unit, :iex, :mix],
      plt_file: {:no_warn, "priv/plts/elixir-#{System.version()}-erlang-otp-#{System.otp_release()}.plt"}
    ]
  end

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # web
      {:phoenix, "~> 1.7.14"},
      {:phoenix_html, "~> 4.1"},
      {:phoenix_live_view, "~> 1.0.0-rc.7", override: true},
      {:bandit, "~> 1.5"},

      # graphql
      {:absinthe, "~> 1.7"},
      {:absinthe_plug, "~> 1.5"},

      # database
      {:phoenix_ecto, "~> 4.5"},
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
      {:ex_toolkit, "~> 0.12.4"},

      # clustering
      {:dns_cluster, "~> 0.2.0"},

      # monitoring
      {:telemetry_metrics, "~> 1.0"},
      {:telemetry_poller, "~> 1.0"},
      {:phoenix_live_dashboard, "~> 0.8.3"},
      {:ecto_psql_extras, "~> 0.8.0"},

      # assets
      {:esbuild, "~> 0.8", runtime: Mix.env() == :dev},
      {:tailwind, "~> 0.3.0", runtime: Mix.env() == :dev},
      {:heroicons,
       github: "tailwindlabs/heroicons", tag: "v2.1.4", sparse: "optimized", app: false, compile: false, depth: 1},

      # development
      {:phoenix_live_reload, "~> 1.2", only: :dev},

      # testing
      {:floki, ">= 0.30.0", only: :test},

      # tools
      {:igniter, "~> 0.5", only: [:dev, :test]},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.3", only: [:dev, :test], runtime: false},
      {:styler, "~> 1.0", only: [:dev, :test], runtime: false},
      {:tailwind_formatter, "~> 0.4.0", only: [:dev, :test], runtime: false},
      {:doctest_formatter, "~> 0.4.0", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.29", only: :dev, runtime: false},
      {:sobelow, "~> 0.12", only: [:dev, :test], runtime: false},
      {:mix_audit, "~> 2.1", only: [:dev, :test], runtime: false}
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
      "lint.sobelow": ["sobelow --threshold low --ignore Config.HTTPS --ignore Config.CSP"],
      lint: ["lint.dialyzer", "lint.credo", "lint.sobelow"],
      "clean.all": ["clean", "deps.clean --unlock --unused", "assets.clean"],
      check: [
        "deps.unlock --check-unused",
        "deps.audit --format human",
        "hex.audit",
        "clean",
        "compile --all-warnings --warnings-as-errors",
        "format --check-formatted",
        "credo --strict --all",
        "test --warnings-as-errors"
      ],
      "assets.clean": ["phx.digest.clean"],
      "assets.setup": ["tailwind.install --if-missing", "esbuild.install --if-missing"],
      "assets.build": ["tailwind estevao", "esbuild estevao"],
      "assets.deploy": ["tailwind estevao --minify", "esbuild estevao --minify", "phx.digest"]
    ]
  end
end
