defmodule EstevaoWeb.Router do
  use EstevaoWeb, :router

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
    plug :auth
  end

  scope "/", EstevaoWeb do
    pipe_through :browser

    live "/", HomeLive.Index, :index
    get "/:slug", RedirectController, :show
  end

  scope "/admin", EstevaoWeb do
    pipe_through :browser
    pipe_through :admin

    live "/", AdminLive.Index, :index

    scope "/links" do
      live "/", LinkLive.Index, :index
      live "/new", LinkLive.Index, :new
      live "/:id/edit", LinkLive.Index, :edit

      live "/:id", LinkLive.Show, :show
      live "/:id/show/edit", LinkLive.Show, :edit
    end
  end

  # Other scopes may use custom stacks.
  scope "/api", EstevaoWeb do
    pipe_through :api

    get "/", ApiController, :index
  end

  defp auth(conn, _opts) do
    username = System.fetch_env!("AUTH_USERNAME")
    password = System.fetch_env!("AUTH_PASSWORD")
    Plug.BasicAuth.basic_auth(conn, username: username, password: password)
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:estevao, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: EstevaoWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
