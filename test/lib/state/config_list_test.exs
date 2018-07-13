defmodule StateMachineEndpoint.State.ConfigListTest do
  use ExUnit.Case
  alias StateMachineEndpoint.State.ConfigList
  alias StateMachineEndpoint.State.Config

  @config_1(%Config{id: "config_1", path: "/test/path-1", method: "GET", json: %{ "body" => "config_1" } })
  @config_2(%Config{id: "config_2", path: "/test/path-2", method: "GET", json: %{ "body" => "config_2" } })
  @config_3(%Config{id: "config_3", path: "/test/path-3", method: "GET", json: %{ "body" => "config_3" } })

  @config_list(%ConfigList{list: [@config_1, @config_2]})

  test "duplicate?/2" do
    assert ConfigList.duplicate?(@config_list, @config_1) == true
    assert ConfigList.duplicate?(@config_list, @config_2) == true
    assert ConfigList.duplicate?(@config_list, @config_3) == false
  end

  test "get/1" do
    assert ConfigList.get(@config_list) == [@config_1, @config_2]
  end

  test "set/2" do
    config = %Config{path: "/hello-test"}
    assert ConfigList.set([], config) == %ConfigList{list: [config]}
  end

  test "add/2" do
    config_1 = %Config{path: "/hello-test"}
    config_2 = %Config{path: "/hello-test-1"}
    config_3 = %Config{path: "/hello-test-1"}

    config_list = %ConfigList{}

    # Add first config
    new_config_list = ConfigList.add(config_list, config_1)
    assert new_config_list == %ConfigList{list: [config_1]}

    # Add next new config
    next_config_list = ConfigList.add(new_config_list, config_2)
    assert next_config_list == %ConfigList{list: [config_1, config_2]}

    # Add a duplicated path config (expect last list!!)
    final_config_list = ConfigList.add(next_config_list, config_3)

    # No duplicated routes
    assert final_config_list == next_config_list
  end
end