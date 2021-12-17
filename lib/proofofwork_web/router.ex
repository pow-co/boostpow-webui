defmodule ProofofworkWeb.Router do
  use ProofofworkWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v0", ProofofworkWeb.Api, as: :api do

    post "/transactions/jobs", JobTransactionsController, :create
    get "/mining/jobs", MiningJobsController, :index

  end

  scope "/api/v1", ProofofworkWeb.Api, as: :api do

    pipe_through :api

    get "/tx/:txid", TransactionsController, :show

    get "/jobs", JobsController, :index
    get "/jobs/:txid", JobsController, :show
    get "/jobs/from/:start_date/to/:end_date", JobsController, :date_range

    get "/work", WorkController, :index
    get "/work/since/:date", WorkController, :since_date
    get "/work/from/:start_date/to/:end_date", WorkController, :date_range

    get "/proofs", ProofsController, :index

    get "/content/:content", ContentController, :show

  end

  scope "/", ProofofworkWeb do
    pipe_through :browser

    get "/view/:txid", ContentController, :show

    get "/", JobsController, :mined
    get "/jobs/mined", JobsController, :mined
    get "/jobs/not_mined", JobsController, :notmined
    get "/jobs/new", JobsController, :new
    get "/", ProofsController, :index
    get "/:txid", ContentController, :show
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
