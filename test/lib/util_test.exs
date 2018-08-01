defmodule StateMachineEndpoint.UtilTest do
  use ExUnit.Case
  alias StateMachineEndpoint.Util
  alias StateMachineEndpoint.State.{ConfigList, Config}

  @config_1(%Config{id: "config_1", path: "/test/path-1", method: "GET", json: %{ "body" => "config_1" }, hash: "1234"})
  @config_2(%Config{id: "config_2", path: "/test/path-2", method: "GET", json: %{ "body" => "config_2" }, hash: "1234" })
  @config_3(%Config{id: "config_3", path: "/test/path-3", method: "GET", json: %{ "body" => "config_3" }, hash: "1234" })
  @config_4(%Config{id: "config_4", path: "/test/path-4", method: "GET", json: %{ "body" => "config_4" }, hash: "1234" })

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
      "hash" => "1234",
      "json" => "{\n  \"body\": \"config_1\"\n}"
    }
    assert Enum.at(ui_endpoint_list, 1) == %{
      "id" => "config_2",
      "method" => "GET",
      "name" => "app-1",
      "path" => "/test/path-2",
      "hash" => "1234",
      "json" => "{\n  \"body\": \"config_2\"\n}"
    }
    assert Enum.at(ui_endpoint_list, 2) == %{
      "id" => "config_3",
      "method" => "GET",
      "name" => "app-2",
      "path" => "/test/path-3",
      "hash" => "1234",
      "json" => "{\n  \"body\": \"config_3\"\n}"
    }
    assert Enum.at(ui_endpoint_list, 3) == %{
      "id" => "config_4",
      "method" => "GET",
      "name" => "app-2",
      "path" => "/test/path-4",
      "hash" => "1234",
      "json" => "{\n  \"body\": \"config_4\"\n}"
    }
  end
end
