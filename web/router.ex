defmodule StateMachineEndpoint.Router do
  use StateMachineEndpoint.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", StateMachineEndpoint do
    pipe_through :api

    get "/:app_id/*path", ApiController, :get
    post "/:app_id/*path", ApiController, :post
    put "/:app_id/*path", ApiController, :put
  end

  scope "/push-state", StateMachineEndpoint do
    pipe_through :api

    post "/", EndpointController, :create
  end

  scope "/pull-state", StateMachineEndpoint do
    pipe_through :api

    post "/", EndpointController, :delete
  end
end
