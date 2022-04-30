defmodule Estevao.Shortner.Link do
  use Estevao.Schema

  @url_regex ~r/https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()!@:%_\+.~#?&\/\/=]*)/
  @slug_alphabet "123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ"

  @derive {Phoenix.Param, key: :slug}
  schema "links" do
    field :slug, :string
    field :url, :string
    field :visits, :integer, default: 0

    timestamps()
  end

  @databases ~w(
    arangodb
    cassandra
    couchdb
    elasticsearch
    faunadb
    hbase
    hive
    mongodb
    mysql
    neo4j
    postgres
    redis
    sqlite
    sqlserver
    supabase
  )
  @tools ~w(
    audacity
    bash
    dbbrowser
    dbeaver
    docker
    emacs
    firefox
    gimp
    git
    inkscape
    insomnia
    jupyter
    livebook
    make
    obs
    pandoc
    podman
    postman
    tmux
    typora
    vagrant
    vim
    xonsh
    zathura
    zeal
    zsh
  )
  @programming_languages ~w(
    C
    C#
    C++
    R
    clojure
    crystal
    dart
    elixir
    elm
    erlang
    go
    haskell
    java
    javascript
    julia
    kotlin
    latex
    lisp
    lua
    nodejs
    perl
    php
    python
    ruby
    rust
    scala
    solidity
    stata
    swift
    tex
    typescript
  )
  @libraries ~w(
    absinthe
    broadway
    django
    ecto
    explorer
    flask
    laravel
    nerves
    nextjs
    nx
    phoenix
    rails
    reactjs
    svelte
    tailwind
    vuejs
  )
  @notes ~w(
    auth
    design
  )
  @general ~w(
    bio
    blog
    cv
    gh
    github
    gitlab
    gl
    goodreads
    in
    instagram
    keybase
    lichess
    linkedin
    reddit
    revolut
    strava
    telegram
    trello
    tw
    twitch
    twitter
    wishlist
    youtube
  )

  @reserved_names Enum.concat([
                    @databases,
                    @programming_languages,
                    @libraries,
                    @notes,
                    @general
                  ])

  @required_fields [:url]
  @optional_fields [:slug]
  @doc false
  def create_changeset(link, attrs) do
    link
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_format(:url, @url_regex)
    |> generate_slug()
    |> validate_exclusion(:slug, @reserved_names)
    |> unique_constraint(:slug)
  end

  @optional_fields [:slug, :visits]
  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_format(:url, @url_regex)
    |> unique_constraint(:slug)
  end

  alias EstevaoWeb.Router.Helpers, as: Routes

  def link(link) do
    Routes.link_url(EstevaoWeb.Endpoint, :redirect_to, link)
  end

  defp generate_slug(%Ecto.Changeset{valid?: true, changes: changes} = changeset)
       when not is_map_key(changes, :slug) do
    changeset
    |> change(slug: Nanoid.generate(6, @slug_alphabet))
  end

  defp generate_slug(changeset), do: changeset
end
