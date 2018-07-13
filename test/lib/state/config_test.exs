defmodule StateMachineEndpoint.State.ConfigTest do
  use ExUnit.Case
  alias StateMachineEndpoint.State.Config

  test "equal" do
    json = %{"body" => nil}
    config_1 = %Config{path: "/test/path-1", method: "POST", json: json}

    assert Config.equal(["test", "path-1"], "POST", config_1) == json
  end
end
