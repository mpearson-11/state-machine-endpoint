defmodule StateMachineEndpoint.State do
  defstruct [endpoints: %{}]

  alias StateMachineEndpoint.State
  alias StateMachineEndpoint.State.{Config, ConfigList}

  def get_endpoints(%State{ endpoints: e }), do: e

  defp create_endpoints(state, endpoint) do
    id = endpoint |> Config.get(:id)
    old_endpoints = get_endpoints(state)

    if !Map.has_key?(old_endpoints, id) == true do
      Map.put(old_endpoints, id, %ConfigList{list: [endpoint]})
    else
      Map.put(old_endpoints, id, ConfigList.add(old_endpoints[id], endpoint))
    end
  end

  def set_endpoints(state, endpoint) do
    %State{endpoints: create_endpoints(state, endpoint)}
  end

  def get_by_id(state, id) do
    endpoints = get_endpoints(state)

    if Map.has_key?(endpoints, id) do
      endpoints[id]
    else
      nil
    end
  end

  def reduce_to_list(%ConfigList{list: config_list}, hash) do
    Enum.reduce(config_list, [], fn(config, acc) ->
      if hash != Config.get(config, :hash) do
        acc ++ [config]
      else
        acc
      end
    end)
  end

  def remove_endpoint_path(endpoints, id, hash) do
    endpoint_list = %ConfigList{list: reduce_to_list(endpoints[id], hash) }
    Map.put(endpoints, id, endpoint_list)
  end
end
