defmodule StateMachineEndpoint.State.ConfigTest do
  use ExUnit.Case
  alias StateMachineEndpoint.State.Config

  test "equal/3" do
    json = %{"body" => nil}
    config_1 = %Config{path: "/test/path-1", method: "POST", json: json}

    assert Config.equal(["test", "path-1"], "POST", config_1) == true
    assert Config.equal(["test", "path-2"], "GET", config_1) == false
  end
end
