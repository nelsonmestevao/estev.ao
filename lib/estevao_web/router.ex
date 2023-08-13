defmodule EstevaoWeb.Router do
  use EstevaoWeb, :router

  import Phoenix.LiveDashboard.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {EstevaoWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :admin do
    plug :basic_auth
  end

  scope "/api", EstevaoWeb do
    pipe_through :api

    get "/", ApiController, :index

    scope "/links" do
      post "/", LinkController, :create
      get "/:slug", LinkController, :show
    end
  end

  scope "/api" do
    pipe_through :admin

    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: EstevaoWeb.Schema
    forward "/graphql", Absinthe.Plug, schema: EstevaoWeb.Schema
  end

  scope "/", EstevaoWeb do
    pipe_through :browser

    live "/", HomeLive.Index, :index

    scope "/admin" do
      pipe_through :admin

      live "/", AdminLive.Index, :index

      scope "/links" do
        live "/", LinkLive.Index, :index
        live "/new", LinkLive.Index, :new
        live "/:id/edit", LinkLive.Index, :edit

        live "/:id", LinkLive.Show, :show
        live "/:id/show/edit", LinkLive.Show, :edit
      end

      live_dashboard "/dashboard", metrics: EstevaoWeb.Telemetry
    end

    get "/_version", ApiController, :version

    get "/:slug", RedirectController, :show
  end

  defp basic_auth(conn, _opts) do
    username = Application.get_env(:estevao, :basic_auth)[:username]
    password = Application.get_env(:estevao, :basic_auth)[:password]

    Plug.BasicAuth.basic_auth(conn, username: username, password: password)
  end

  # Enable Swoosh mailbox preview in development
  if Application.compile_env(:estevao, :dev_routes) do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
