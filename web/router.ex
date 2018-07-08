defmodule StateMachineEndpoint.Router do
  use StateMachineEndpoint.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", StateMachineEndpoint do
    pipe_through :api
  end
end
