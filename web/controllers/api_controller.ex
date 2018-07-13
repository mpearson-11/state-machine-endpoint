defmodule StateMachineEndpoint.ApiController do
  use StateMachineEndpoint.Web, :controller

  alias StateMachineEndpoint.{Apps, Util}
  alias StateMachineEndpoint.State.{Config, ConfigList}

  def get_data([], _path), do: %{message: "No match found for path!!" }
  def get_data([config], path) do
    %Config{json: json_data, path: config_path} = config
    %{"data" => json_data, "params" => Util.get_param_matches(path, config_path)}
  end

  def find_config_list(list, path, method) do
    list
    |> Enum.filter(&(Config.equal(path, method, &1)))
    |> get_data(path)
  end

  def get_endpoint_data(nil, _path, _method), do: %{ message: "App does not exist!!" }
  def get_endpoint_data(configs, path, method) do
    configs
    |> ConfigList.get
    |> find_config_list(path, method)
  end

  def get(conn, %{"path" => path, "app_id" => id}) do
    data = id
    |> Apps.get_endpoint
    |> get_endpoint_data(path, "GET")

    json conn, data
  end

  def post(conn, %{"path" => path, "app_id" => id}) do
    data = id
    |> Apps.get_endpoint
    |> get_endpoint_data(path, "POST")

    json conn, data
  end

  def put(conn, %{"path" => path, "app_id" => id}) do
    data = id
    |> Apps.get_endpoint
    |> get_endpoint_data(path, "PUT")

    json conn, data
  end
end
