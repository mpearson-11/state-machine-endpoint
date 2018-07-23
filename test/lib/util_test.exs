defmodule StateMachineEndpoint.UtilTest do
  use ExUnit.Case
  alias StateMachineEndpoint.Util
  alias StateMachineEndpoint.State.{ConfigList, Config}

  @config_1(%Config{id: "config_1", path: "/test/path-1", method: "GET", json: %{ "body" => "config_1" } })
  @config_2(%Config{id: "config_2", path: "/test/path-2", method: "GET", json: %{ "body" => "config_2" } })
  @config_3(%Config{id: "config_3", path: "/test/path-3", method: "GET", json: %{ "body" => "config_3" } })
  @config_4(%Config{id: "config_4", path: "/test/path-4", method: "GET", json: %{ "body" => "config_4" } })

  @config_list_1(%ConfigList{list: [@config_1, @config_2]})
  @config_list_2(%ConfigList{list: [@config_3, @config_4]})

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

  test "convert_endpoints_to_list/1" do
    endpoints = %{ "app-1" => @config_list_1, "app-2" => @config_list_2 }
    ui_endpoint_list = Util.convert_endpoints_to_list(endpoints)

    assert Enum.at(ui_endpoint_list, 0) == %{
      "id" => "config_1",
      "method" => "GET",
      "name" => "app-1",
      "path" => "/test/path-1",
      "uri" => "/api/app-1/test/path-1"
    }
    assert Enum.at(ui_endpoint_list, 1) == %{
      "id" => "config_2",
      "method" => "GET",
      "name" => "app-1",
      "path" => "/test/path-2",
      "uri" => "/api/app-1/test/path-2"
    }
    assert Enum.at(ui_endpoint_list, 2) == %{
      "id" => "config_3",
      "method" => "GET",
      "name" => "app-2",
      "path" => "/test/path-3",
      "uri" => "/api/app-2/test/path-3"
    }
    assert Enum.at(ui_endpoint_list, 3) == %{
      "id" => "config_4",
      "method" => "GET",
      "name" => "app-2",
      "path" => "/test/path-4",
      "uri" => "/api/app-2/test/path-4"
    }
  end
end
