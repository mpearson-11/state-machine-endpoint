defmodule StateMachineEndpoint.Endpoints do
  def get_endpoints do
    GenServer.call(EndpointCollector, {:get, :endpoints})
  end

  def get_endpoint(id) do
    GenServer.call(EndpointCollector, {:get, :endpoint, id })
  end

  def delete_endpoint(id) do
    if get_endpoint(id) do
      GenServer.cast(EndpointCollector, {:delete, :endpoint, id })
      %{message: "Endpoint for app: #{id} was deleted !!"}
    else
      %{message: "Endpoint for app: #{id} doesn't exist!!"}
    end
  end

  def create_endpoint(endpoint) do
    GenServer.cast(EndpointCollector, {:set, :endpoint, endpoint})
  end
end
