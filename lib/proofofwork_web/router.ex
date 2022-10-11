defmodule ProofofworkWeb.Router do
  use ProofofworkWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", ProofofworkWeb do
    pipe_through :browser

    get "/jobs/mined", JobsController, :mined
    get "/jobs/not_mined", JobsController, :notmined
    get "/jobs/pending", JobsController, :notmined
    get "/jobs/new", JobsController, :new

    get "/token", TokenController, :index
    get "/", ContentController, :index
    get "/top-boosted-last-hour", ContentController, :last_hour
    get "/top-boosted-last-day", ContentController, :last_day
    get "/top-boosted-last-week", ContentController, :last_week
    get "/top-boosted-last-month", ContentController, :last_month
    get "/top-boosted-last-quarter", ContentController, :last_quarter
    get "/top-boosted-last-year", ContentController, :last_year
    get "/top-boosted-all-time", ContentController, :all_time
    get "/", ContentController, :index
    get "/rankings", ContentController, :index
    get "/:txid", ContentController, :show
    get "/:txid/pending", ContentController, :show
    get "/view/:txid", ContentController, :show

    get "/-/:channel", ChannelsController, :show

  end

  # Other scopes may use custom stacks.
  # scope "/api", ProofofworkWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: ProofofworkWeb.Telemetry
    end
  end
end
