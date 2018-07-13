defmodule StateMachineEndpoint.UtilTest do
  use ExUnit.Case
  alias StateMachineEndpoint.Util

  test "matches path correctly" do
    assert Util.path_eq?(["home", "help"], "/home/help") == true
  end

  test "matches path with :params correctly" do
    assert Util.path_eq?(["home", "help"], "/home/:params") == true
  end

  test "does not match params with different length" do
    assert Util.path_eq?(["home", "help"], "/home/:params/stuff") == false
  end

  test "does not match params with different params" do
    assert Util.path_eq?(["home", "help"], "/home/wrong") == false
  end
end
