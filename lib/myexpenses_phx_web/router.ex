defmodule MyexpensesPhxWeb.Router do
  use MyexpensesPhxWeb, :router

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

  scope "/auth", MyexpensesPhxWeb do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback
  end

  scope "/", MyexpensesPhxWeb do
    pipe_through :browser
    get "/", PageController, :index

    get "/logout", AuthController, :logout
  end

  # Other scopes may use custom stacks.
  # scope "/api", MyexpensesPhxWeb do
  #   pipe_through :api
  # end
end
