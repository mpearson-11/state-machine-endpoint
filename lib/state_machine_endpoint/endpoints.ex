defmodule StateMachineEndpoints.Endpoints do
  def get_endpoints do
    GenServer.call(EndpointCollector, {:get, :endpoints})
  end

  def get_endpoint(id) do
    GenServer.call(EndpointCollector, {:get, :endpoint, id})
  end
end
