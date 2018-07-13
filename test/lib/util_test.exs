defmodule StateMachineEndpoint.UtilTest do
  use ExUnit.Case
  alias StateMachineEndpoint.Util

  test "path_eq/2" do
    assert Util.path_eq?(["home", "help"], "/home/help") == true
    assert Util.path_eq?(["home", "help"], "/home/:params") == true
    assert Util.path_eq?(["home", "help"], "/home/:params/stuff") == false
    assert Util.path_eq?(["home", "help"], "/home/wrong") == false
  end

  test "get_param_matches/2" do
    assert Util.get_param_matches(["home", "help"], "/home/:params/meh") == %{}
    assert Util.get_param_matches(["home", "help"], "/home/:params") == %{"params" => "help"}
  end
end
