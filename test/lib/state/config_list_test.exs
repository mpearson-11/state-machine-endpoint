defmodule StateMachineEndpoint.State.ConfigListTest do
  use ExUnit.Case
  alias StateMachineEndpoint.State.ConfigList
  alias StateMachineEndpoint.State.Config

  @config_1(%Config{id: "config_1", path: "/test/path-1", method: "GET", json: %{ "body" => "config_1" } })
  @config_2(%Config{id: "config_2", path: "/test/path-2", method: "GET", json: %{ "body" => "config_2" } })
  @config_3(%Config{id: "config_3", path: "/test/path-3", method: "GET", json: %{ "body" => "config_3" } })

  @config_list(%ConfigList{list: [@config_1, @config_2]})

  test "duplicate?" do
    assert ConfigList.duplicate?(@config_list, @config_1) == true
    assert ConfigList.duplicate?(@config_list, @config_2) == true
    assert ConfigList.duplicate?(@config_list, @config_3) == false
  end

  test "get" do
    assert ConfigList.get(@config_list) == [@config_1, @config_2]
  end

  test "set" do
    config = %Config{path: "/hello-test"}
    assert ConfigList.set([], config) == %ConfigList{list: [config]}
  end
end