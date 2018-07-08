defmodule Endpoint do
  defstruct [id: nil, url: "", method: "GET", json: %{}]

  def get(e, :id), do: e.__struct__.id
  def get(e, :url), do: e.__struct__.url
  def get(e, :method), do: e.__struct__.method
  def get(e, :json), do: e.__struct__.json
end

defmodule State do
  defstruct [endpoints: %{}]

  defp create_endpoints(%State{endpoints: oe}, endpoint) do
    id = endpoint
    |> Endpoint.get(:id)

    Map.put(oe, id, endpoint)
  end

  def set_endpoints(%State{endpoints: oe}, endpoint) do
    %State{endpoints: create_endpoints(oe, endpoint)}
  end

  def get_endpoints(%State{ endpoints: e }), do: e

  def get_by_id(state, id) do
    endpoints = get_endpoints(state)

    if Map.has_key?(endpoints, id) do
      endpoints[id]
    else
      nil
    end
  end
end

defmodule StateMachineEndpoint.GenServer do
  use GenServer

  def start_link(params) do
    GenServer.start_link(__MODULE__, params, __MODULE__)
  end

  def init(_params) do
    {:ok, %State{}}
  end

  def handle_cast({:set, :endpoint, endpoint}, state) do
    {:noreply, State.set_endpoints(state, endpoint)}
  end

  def handle_call({:get, :endpoints}, state) do
    {:reply, State.get_endpoints(state), state}
  end

  def handle_call({:get, :endpoint, id}, state) do
    endpoint = state
    |> State.get_endpoints
    |> State.get_by_id(id)

    {:reply, endpoint, state}
  end
end
