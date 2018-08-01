defmodule StateMachineEndpoint.Apps do
  @moduledoc false

  def get_endpoints do
    Server |> GenServer.call({:get, :endpoints})
  end

  def get_endpoint(id) do
    Server |> GenServer.call({:get, :endpoint, id})
  end

  def delete_endpoint(id) do
    if get_endpoint(id) do
      Server |> GenServer.cast({:delete, :endpoint, id})
      %{message: "Endpoint for app: #{id} was deleted !!"}
    else
      %{message: "Endpoint for app: #{id} doesn't exist!!"}
    end
  end

  def delete_endpoint_path(id, hash) do
    if get_endpoint(id) do
      Server |> GenServer.cast({:delete_endpoint, :path, id, hash})
      %{message: "Endpoint for app: #{id} with hash: #{hash} was deleted !!"}
    else
      %{message: "Endpoint for app: #{id} doesn't exist!!"}
    end
  end

  def create_endpoint(endpoint) do
    Server |> GenServer.cast({:set, :endpoint, endpoint})
  end

  def reset_endpoints do
    Server |> GenServer.cast(:clear)
  end
end
