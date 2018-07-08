defmodule StateMachineEndpoint.State do
  alias StateMachineEndpoint.State
  alias StateMachineEndpoint.State.AppEndpoint

  defstruct [endpoints: %{}]

  defp create_endpoints(%State{endpoints: oe}, endpoint) do
    id = endpoint |> AppEndpoint.get(:id)
    Map.put(oe, id, endpoint)
  end

  def set_endpoints(state, endpoint) do
    %State{endpoints: create_endpoints(state, endpoint)}
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
