[
  import_deps: [:ecto, :phoenix],
  plugins: [TailwindFormatter, Phoenix.LiveView.HTMLFormatter],
  heex_line_length: 120,
  inputs: [
    "*.{heex,ex,exs}",
    "priv/*/seeds.exs",
    "priv/repo/seeds/*.exs",
    "{config,lib,test}/**/*.{heex,ex,exs}"
  ],
  subdirectories: ["priv/*/migrations"]
]
