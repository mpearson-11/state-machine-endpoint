defmodule StateMachineEndpoint.StateTest do
  use ExUnit.Case

  alias StateMachineEndpoint.State
  alias StateMachineEndpoint.State.{Config, ConfigList}

  test "get_endpoints/1" do
    state = %State{endpoints: nil}
    assert State.get_endpoints(state) == nil
  end

  test "set_endpoints/2" do
    endpoint_1 = %Config{id: "config_1", path: "/path-1"}
    endpoint_2 = %Config{id: "config_1", path: "/path-2"}
  
    config_list = ConfigList.add(endpoint_1, %ConfigList{})

    new_state = State.set_endpoints(%State{}, endpoint_1)
    endpoints = State.get_endpoints(new_state)

    assert endpoints["config_1"] == config_list
  end
end