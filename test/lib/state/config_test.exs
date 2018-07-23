defmodule StateMachineEndpoint.State.ConfigTest do
  use ExUnit.Case
  alias StateMachineEndpoint.State.Config

  test "equal/3" do
    json = %{"body" => nil}
    config_1 = %Config{path: "/test/path-1", method: "POST", json: json}

    assert Config.equal(["test", "path-1"], "POST", config_1) == true
    assert Config.equal(["test", "path-2"], "GET", config_1) == false
  end

  test "get/2" do
    json = %{"body" => nil}
    config_1 = %Config{id: "config_1", path: "/test/path-1", method: "POST", json: json}

    assert Config.get(config_1, :id) == "config_1"
    assert Config.get(config_1, :path) == "/test/path-1"
    assert Config.get(config_1, :method) == "POST"
    assert Config.get(config_1, :json) == json
  end
end
