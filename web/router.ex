defmodule StateMachineEndpoint.Router do
  use StateMachineEndpoint.Web, :router
  
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

  scope "/api", StateMachineEndpoint do
    pipe_through :api

    get "/:app_id/*path", ApiController, :get
    post "/:app_id/*path", ApiController, :post
    put "/:app_id/*path", ApiController, :put
  end

  scope "/state", StateMachineEndpoint do
    pipe_through :api

    post "/pull", EndpointController, :delete
    post "/push", EndpointController, :create
    post "/reset", EndpointController, :reset

    # Deal with all other paths
    get "/*path", EndpointController, :error
    post "/*path", EndpointController, :error
  end

  scope "/app", StateMachineEndpoint do
    pipe_through :browser

    get "/", PageController, :index
  end
end
